import 'dart:io';

import 'package:easy_tv_live/provider/download_provider.dart';
import 'package:easy_tv_live/provider/theme_provider.dart';
import 'package:easy_tv_live/util/latency_checker_util.dart';
import 'package:easy_tv_live/widget/focus_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:window_manager/window_manager.dart';

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

  _playVideo() async {
    if (_currentChannel == null) return;
    toastString = S.current.lineToast(_sourceIndex + 1, _currentChannel!.title ?? '');
    setState(() {});
    final url = _currentChannel!.urls![_sourceIndex].toString();
    LogUtil.v('正在播放:$_sourceIndex::${_currentChannel!.toJson()}');
    try {
      if (_playerController != null) {
        _playerController?.removeListener(_videoListener);
        await _playerController?.pause();
        await _playerController?.dispose();
        _playerController = null;
      }
      _playerController = VideoPlayerController.networkUrl(
        Uri.parse(url),
        videoPlayerOptions: VideoPlayerOptions(
          allowBackgroundPlayback: false,
          mixWithOthers: false,
          webOptions: const VideoPlayerWebOptions(controls: VideoPlayerWebOptionsControls.enabled()),
        ),
      )..setVolume(1.0);
      await _playerController!.initialize();
      // debugPrint('MediaInfo::::::${_playerController!.getMediaInfo().toString()}');
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
          toastString = S.current.playError;
        });
      } else {
        setState(() {
          toastString = S.current.switchLine(_sourceIndex + 1);
        });
        Future.delayed(const Duration(seconds: 2), () => _playVideo());
        return;
      }
    }
  }

  _videoListener() {
    if (_playerController == null) return;
    // LogUtil.v('播放状态:::::${_playerController!.value.toString()}');
    if (_playerController!.value.hasError) {
      _sourceIndex += 1;
      if (_sourceIndex > _currentChannel!.urls!.length - 1) {
        _sourceIndex = 0;
        setState(() {
          toastString = S.current.playReconnect;
        });
      } else {
        setState(() {
          toastString = '${S.current.switchLine(_sourceIndex + 1)}...';
        });
      }
      Future.delayed(const Duration(seconds: 2), () => _playVideo());
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
    LogUtil.v('onTapChannel:::::${_currentChannel?.toJson()}');
    _playVideo();
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.black
      ..textColor = Colors.black
      ..backgroundColor = Colors.white70;
    if (!EnvUtil.isMobile) windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    _loadData();
  }

  _loadData() async {
    await _parseData();
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

  _parseData() async {
    final resMap = await M3uUtil.getDefaultM3uData();
    LogUtil.v('_parseData:::::$resMap');
    _channelListModel = resMap;
    _sourceIndex = 0;
    if ((_channelListModel?.playList?.isNotEmpty) ?? false) {
      setState(() {
        final firstPlayList = _channelListModel!.playList!.first;
        _currentChannel = firstPlayList.channel!.first;
        _playVideo();
      });
      if (_channelListModel!.type == PlayListType.m3u) {
        if (_channelListModel?.epgUrl != null && _channelListModel?.epgUrl != '') {
          EpgUtil.loadEPGXML(_channelListModel!.epgUrl!);
        } else {
          EpgUtil.loadEPGXML('http://epg.51zmt.top:8000/cc.xml');
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
            drawChild: ChannelDrawerPage(
              channelListModel: _channelListModel,
              onTapChannel: _onTapChannel,
              isLandscape: false,
            ),
          );
        },
        landscape: (context) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (!didPop) {
                SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
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
              body: toastString == 'UNKNOWN'
                  ? InkWell(
                      canRequestFocus: false,
                      onTap: _parseData,
                      onHover: (bool isHover) {
                        if (isHover) {
                          windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: true);
                        } else {
                          windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: false);
                        }
                      },
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
                      isLandscape: true),
            ),
          );
        },
      ),
    );
  }

  Future<void> _changeChannelSources() async {
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
                                  decoration: BoxDecoration(
                                    color: snapshot.data,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  })),
            ),
          );
        });
    if (selectedIndex != null && _sourceIndex != selectedIndex) {
      _sourceIndex = selectedIndex;
      LogUtil.v('切换线路:====线路${_sourceIndex + 1}');
      _playVideo();
    }
  }
}
