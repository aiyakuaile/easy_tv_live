import 'dart:async';
import 'dart:io';

import 'package:easy_tv_live/provider/download_provider.dart';
import 'package:easy_tv_live/provider/theme_provider.dart';
import 'package:easy_tv_live/util/latency_checker_util.dart';
import 'package:easy_tv_live/util/remote_util.dart';
import 'package:easy_tv_live/widget/focus_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'channel_drawer_page.dart';
import 'entity/play_channel_list_model.dart';
import 'generated/l10n.dart';
import 'mobile_video_widget.dart';
import 'table_video_widget.dart';
import 'tv/tv_page.dart';
import 'util/check_version_util.dart';
import 'util/env_util.dart';
import 'util/epg_util.dart';
import 'util/log_util.dart';
import 'util/m3u_util.dart';
import 'widget/empty_page.dart';

class LiveHomePage extends StatefulWidget {
  const LiveHomePage({super.key});

  @override
  State<LiveHomePage> createState() => _LiveHomePageState();
}

class _LiveHomePageState extends State<LiveHomePage> {
  String toastString = S.current.loading;

  PlayChannelListModel? _channelListModel;

  Channel? _currentChannel;

  int _sourceIndex = 0;

  VideoPlayerController? _playerController;

  bool isBuffering = false;

  bool isPlaying = false;
  double aspectRatio = 1.78;

  bool _drawerIsOpen = false;

  int _channelSerialNum = 1;

  _playVideo(String entMsg) async {
    if (_currentChannel == null) return;
    _channelSerialNum = _currentChannel!.serialNum ?? 1;
    int timeoutNum = 15;
    if (mounted) {
      context.read<ThemeProvider>().setPrePlaySerialNum(_channelSerialNum);
      timeoutNum = context.read<ThemeProvider>().timeoutSwitchLine;
    }
    toastString = S.current.lineToast(_sourceIndex + 1, _currentChannel!.title ?? '');
    setState(() {});
    final url = _currentChannel!.urls![_sourceIndex > _currentChannel!.urls!.length - 1 ? 0 : _sourceIndex].toString();
    LogUtil.v('PlayVideo:【$entMsg】正在播放:$_sourceIndex::${_currentChannel!.toJson()}');
    try {
      if (_playerController != null) {
        _playerController?.removeListener(_videoListener);
        await _playerController?.pause();
        if (_playerController!.value.isInitialized) {
          await _playerController?.dispose();
        }
        _playerController = null;
        setState(() {});
      }
      await Future.delayed(Duration.zero);
      LogUtil.v('检测User-Agent::::::${_channelListModel?.uaHint}');
      final httpHeader = <String, String>{};
      if (_channelListModel != null && _channelListModel!.uaHint != null && _channelListModel!.uaHint!.isNotEmpty) {
        httpHeader['User-Agent'] = _channelListModel!.uaHint!;
      }
      _playerController = VideoPlayerController.networkUrl(
        Uri.parse(url),
        videoPlayerOptions: VideoPlayerOptions(
          allowBackgroundPlayback: false,
          mixWithOthers: false,
          webOptions: const VideoPlayerWebOptions(controls: VideoPlayerWebOptionsControls.enabled()),
        ),
        httpHeaders: httpHeader,
      )..setVolume(1.0);
      await _playerController!.initialize().timeout(
        Duration(seconds: timeoutNum),
        onTimeout: () {
          LogUtil.v('视频初始化超时');
          throw TimeoutException('Video initialization timeout', Duration(seconds: timeoutNum));
        },
      );
      _playerController!.addListener(_videoListener);
      _playerController!.play();
      setState(() {
        toastString = S.current.loading;
        aspectRatio = _playerController?.value.aspectRatio ?? 1.78;
      });
    } catch (e) {
      LogUtil.v('播放出错:::::$e');
      _sourceIndex += 1;
      if (_sourceIndex > _currentChannel!.urls!.length - 1) {
        _sourceIndex = _currentChannel!.urls!.length - 1;
        setState(() {
          toastString = S.current.playError(_currentChannel!.title ?? '');
        });
      } else {
        setState(() {
          toastString = S.current.switchLine(_sourceIndex + 1);
        });
        await Future.delayed(const Duration(seconds: 2));
        _playVideo('错误拦截后再次进入，并触发切换线路');
      }
    }
  }

  _videoListener() async {
    if (_playerController == null) return;
    // LogUtil.v('播放状态:::::${_playerController!.value.toString()}');
    if (_playerController!.value.hasError && !_playerController!.value.isCompleted) {
      _sourceIndex += 1;
      if (_sourceIndex > _currentChannel!.urls!.length - 1) {
        if (_playerController!.value.errorDescription != null) {
          setState(() {
            toastString = S.current.playError(_currentChannel!.title ?? '');
          });
        } else {
          _sourceIndex = 0;
          setState(() {
            toastString = S.current.playReconnect;
          });
          await Future.delayed(const Duration(seconds: 2));
          _playVideo('videoListener事件监听进入:触发播放重连:::');
        }
      } else {
        setState(() {
          toastString = '${S.current.switchLine(_sourceIndex + 1)}...';
        });
        await Future.delayed(const Duration(seconds: 2));
        _playVideo('videoListener事件监听进入:触发切换线路:::');
      }
      return;
    }
    if (isBuffering != _playerController!.value.isBuffering) {
      setState(() {
        isBuffering = _playerController!.value.isBuffering;
      });
    }

    if (isPlaying != _playerController!.value.isPlaying) {
      setState(() {
        isPlaying = _playerController!.value.isPlaying;
      });
    }
  }

  _onTapChannel(Channel? model) {
    _currentChannel = model;
    _sourceIndex = 0;
    if (_channelListModel != null && model != null) {
      _channelListModel!.playGroupIndex = model.groupIndex;
      _channelListModel!.playChannelIndex = model.channelIndex;
    }
    LogUtil.v('切换频道:::::${_currentChannel?.toJson()}');
    _playVideo('onTapChannel方法进入');
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.black
      ..textColor = Colors.black
      ..backgroundColor = Colors.white70;
    // if (!EnvUtil.isMobile) windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    Future.delayed(Duration.zero, _loadData);
  }

  _loadData() async {
    await RemoteUtil.getRemoteData(context);
    await _parseData(true);
    if (mounted) {
      if (context.read<ThemeProvider>().useAutoUpdate && Platform.isAndroid) {
        final url = await CheckVersionUtil.checkVersionAndAutoUpdate();
        if (mounted && url != null) {
          EasyLoading.showToast('新版本开始下载，稍后为您自动安装', toastPosition: EasyLoadingToastPosition.top);
          context.read<DownloadProvider>().downloadApk(url);
        }
      } else {
        if (context.read<ThemeProvider>().useLightVersionCheck) {
          CheckVersionUtil.checkLightVersion();
        } else {
          CheckVersionUtil.checkVersion(context, false, false);
        }
      }
    }
  }

  @override
  dispose() {
    WakelockPlus.disable();
    _playerController?.removeListener(_videoListener);
    _playerController?.dispose();
    super.dispose();
  }

  _parseData([bool isSkipRestSerialNum = false]) async {
    final resMap = await M3uUtil.getDefaultM3uData();
    _channelListModel = resMap;
    _sourceIndex = 0;
    if (mounted && !isSkipRestSerialNum) {
      context.read<ThemeProvider>().setPrePlaySerialNum(1);
    }
    if ((_channelListModel?.playList?.isNotEmpty) ?? false) {
      if (mounted) {
        final preNum = context.read<ThemeProvider>().prePlaySerialNum;
        final channel = M3uUtil.serialNumMap[preNum.toString()];
        _onTapChannel(channel ?? M3uUtil.serialNumMap['1']);
        if (_channelListModel!.type == PlayListType.m3u) {
          if (_channelListModel?.epgUrl != null && _channelListModel?.epgUrl != '') {
            EpgUtil.loadEPGXML(_channelListModel!.epgUrl!);
          }
        }
      }
    } else {
      setState(() {
        _currentChannel = null;
        _playerController?.dispose();
        _playerController = null;
        toastString = 'UNKNOWN';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (EnvUtil.isTV()) {
      return TvPage(
        channelSerialNum: _channelSerialNum,
        channelListModel: _channelListModel,
        onTapChannel: _onTapChannel,
        toastString: toastString,
        controller: _playerController,
        isBuffering: isBuffering,
        isPlaying: isPlaying,
        aspectRatio: aspectRatio,
        onChangeSubSource: _parseData,
        changeChannelSources: _changeChannelSources,
      );
    }
    return Material(
      child: OrientationLayoutBuilder(
        portrait: (context) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          return MobileVideoWidget(
            toastString: toastString,
            controller: _playerController,
            changeChannelSources: _changeChannelSources,
            isLandscape: false,
            isBuffering: isBuffering,
            isPlaying: isPlaying,
            aspectRatio: aspectRatio,
            onChangeSubSource: _parseData,
            drawChild: ChannelDrawerPage(channelListModel: _channelListModel, onTapChannel: _onTapChannel, isLandscape: false),
            onPreviousChannel: _previousChannel,
            onNextChannel: _nextChannel,
            onSwitchSource: _switchSource,
          );
        },
        landscape: (context) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
              if (!didPop) {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
              }
            },
            child: Scaffold(
              drawer: ChannelDrawerPage(channelListModel: _channelListModel, onTapChannel: _onTapChannel, isLandscape: true),
              drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.3,
              drawerScrimColor: Colors.transparent,
              onDrawerChanged: (bool isOpened) {
                setState(() {
                  _drawerIsOpen = isOpened;
                });
              },
              body: Builder(
                builder: (context) {
                  return CallbackShortcuts(
                    bindings: <ShortcutActivator, VoidCallback>{
                      const SingleActivator(LogicalKeyboardKey.arrowUp): _previousChannel,
                      const SingleActivator(LogicalKeyboardKey.arrowDown): _nextChannel,
                      const SingleActivator(LogicalKeyboardKey.arrowLeft): () => _pushChannelDrawer(context),
                      const SingleActivator(LogicalKeyboardKey.arrowRight): () => _switchSource(),
                      const SingleActivator(LogicalKeyboardKey.arrowRight, alt: true): () => _changeChannelSources(),
                      if (Platform.isMacOS) const SingleActivator(LogicalKeyboardKey.comma, meta: true): () => _pushSettingPage(context),
                      if (Platform.isWindows || Platform.isLinux)
                        const SingleActivator(LogicalKeyboardKey.comma, control: true): () => _pushSettingPage(context),
                    },
                    child: Focus(
                      autofocus: true,
                      child: toastString == 'UNKNOWN'
                          ? InkWell(
                              canRequestFocus: false,
                              onTap: _parseData,
                              // onHover: (bool isHover) {
                              //   if (isHover) {
                              //     windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: true);
                              //   } else {
                              //     windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: false);
                              //   }
                              // },
                              child: EmptyPage(
                                onRefresh: _parseData,
                                onEnterSetting: () async {
                                  await M3uUtil.openAddSource(context);
                                  _parseData();
                                },
                              ),
                            )
                          : TableVideoWidget(
                              toastString: toastString,
                              controller: _playerController,
                              isBuffering: isBuffering,
                              isPlaying: isPlaying,
                              aspectRatio: aspectRatio,
                              drawerIsOpen: _drawerIsOpen,
                              changeChannelSources: _changeChannelSources,
                              onChangeSubSource: _parseData,
                              isLandscape: true,
                              onPreviousChannel: _previousChannel,
                              onNextChannel: _nextChannel,
                              onSwitchSource: _switchSource,
                            ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _changeChannelSources([FocusNode? videoNode]) async {
    LogUtil.v('_changeChannelSources:::::::::::');
    videoNode?.unfocus();
    List<String> sources = _currentChannel!.urls!;
    final selectedIndex = await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.black87,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
            color: Colors.transparent,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(sources.length, (index) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    FocusButton(
                      autofocus: _sourceIndex == index,
                      onTap: _sourceIndex == index
                          ? null
                          : () {
                              Navigator.pop(context, index);
                            },
                      title: S.current.lineIndex(index + 1),
                      selected: _sourceIndex == index,
                    ),
                    Positioned(
                      top: -2,
                      right: 8,
                      child: FutureBuilder<Color>(
                        future: LatencyCheckerUtil.checkLatencies(sources[index]),
                        initialData: Colors.transparent,
                        builder: (BuildContext context, AsyncSnapshot<Color> snapshot) {
                          return Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(color: snapshot.data, borderRadius: BorderRadius.circular(4)),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
    videoNode?.requestFocus();
    if (selectedIndex != null && _sourceIndex != selectedIndex) {
      _sourceIndex = selectedIndex;
      LogUtil.v('切换线路:====线路${_sourceIndex + 1}');
      _playVideo('changeChannelSources方法进入');
    }
  }

  _nextChannel() async {
    if (toastString == 'UNKNOWN') return;
    final lastIndex = _channelSerialNum + 1;
    final channel = M3uUtil.serialNumMap[lastIndex.toString()];
    if (channel != null) {
      _channelListModel!.playChannelIndex = channel.channelIndex;
      _channelListModel!.playGroupIndex = channel.groupIndex;
      _onTapChannel.call(channel);
    } else {
      EasyLoading.showToast('已是最后一个节目');
    }
  }

  _previousChannel() async {
    if (toastString == 'UNKNOWN') return;
    final lastIndex = _channelSerialNum - 1;
    final channel = M3uUtil.serialNumMap[lastIndex.toString()];
    if (channel != null) {
      _channelListModel!.playChannelIndex = channel.channelIndex;
      _channelListModel!.playGroupIndex = channel.groupIndex;
      _onTapChannel.call(channel);
    } else {
      EasyLoading.showToast('已是第一个节目');
    }
  }

  _switchSource() async {
    if (toastString == 'UNKNOWN') return;
    _sourceIndex = (_sourceIndex + 1) % _currentChannel!.urls!.length;
    if (_currentChannel!.urls!.length == 1) {
      EasyLoading.showToast('🤣没有更多线路！');
    }
    _playVideo('switchSource点击屏幕切换线路方法进入');
  }

  _pushSettingPage(BuildContext context) async {
    LogUtil.v('设置：：：：');
    _playerController?.pause();
    await M3uUtil.openAddSource(context);
    final isChange = await M3uUtil.isChangeChannelLink();
    if (isChange) {
      _parseData();
    } else {
      _playerController?.play();
    }
  }

  _pushChannelDrawer(BuildContext context) {
    if (toastString == 'UNKNOWN') return;
    LogUtil.v('节目菜单：：：：');
    Scaffold.of(context).openDrawer();
  }
}
