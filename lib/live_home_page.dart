import 'package:easy_tv_live/util/epg_util.dart';
import 'package:easy_tv_live/widget/focus_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:window_manager/window_manager.dart';

import 'channel_drawer_page.dart';
import 'entity/playlist_model.dart';
import 'generated/l10n.dart';
import 'mobile_video_widget.dart';
import 'table_video_widget.dart';
import 'tv/tv_page.dart';
import 'util/check_version_util.dart';
import 'util/env_util.dart';
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

  PlaylistModel? _videoMap;

  PlayModel? _currentChannel;

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
      _playerController?.removeListener(_videoListener);
      _playerController?.dispose();
      _playerController = VideoPlayerController.networkUrl(
        Uri.parse(url),
        videoPlayerOptions: VideoPlayerOptions(
          allowBackgroundPlayback: false,
          mixWithOthers: false,
          webOptions: const VideoPlayerWebOptions(controls: VideoPlayerWebOptionsControls.enabled()),
        ),
      )..setVolume(1.0);
      await _playerController?.initialize();
      _playerController?.play();
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
    _playerController?.addListener(_videoListener);
  }

  _videoListener() {
    if (_playerController == null) return;
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

  _onTapChannel(PlayModel? model) {
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
    CheckVersionUtil.checkVersion(context, false, false);
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
    _videoMap = resMap;
    _sourceIndex = 0;
    if (_videoMap?.playList?.isNotEmpty ?? false) {
      setState(() {
        String group = _videoMap!.playList!.keys.first.toString();
        String channel = _videoMap!.playList![group]!.keys.first;
        _currentChannel = _videoMap!.playList![group]![channel];
        _playVideo();
      });
      if (_videoMap?.epgUrl != null && _videoMap?.epgUrl != '') {
        EpgUtil.loadEPGXML(_videoMap!.epgUrl!);
      } else {
        EpgUtil.resetEPGXML();
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
        videoMap: _videoMap,
        playModel: _currentChannel,
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
              videoMap: _videoMap,
              playModel: _currentChannel,
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
              drawer: ChannelDrawerPage(videoMap: _videoMap, playModel: _currentChannel, onTapChannel: _onTapChannel, isLandscape: true),
              drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.3,
              drawerScrimColor: Colors.transparent,
              onDrawerChanged: (bool isOpened) {
                setState(() {
                  _drawerIsOpen = isOpened;
                });
              },
              body: toastString == 'UNKNOWN'
                  ? EmptyPage(onRefresh: _parseData)
                  : TableVideoWidget(
                      toastString: toastString,
                      controller: _playerController,
                      isBuffering: isBuffering,
                      isPlaying: isPlaying,
                      aspectRatio: aspectRatio,
                      drawerIsOpen: _drawerIsOpen,
                      changeChannelSources: _changeChannelSources,
                      isLandscape: true),
            ),
          );
        },
      ),
    );
  }

  Future<void> _changeChannelSources() async {
    List<String> sources = _videoMap!.playList![_currentChannel!.group]![_currentChannel!.title]!.urls!;
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
                    return FocusButton(
                      autofocus: _sourceIndex == index,
                      onTap: _sourceIndex == index
                          ? null
                          : () {
                              Navigator.pop(context, index);
                            },
                      title: S.current.lineIndex(index + 1),
                      selected: _sourceIndex == index,
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
