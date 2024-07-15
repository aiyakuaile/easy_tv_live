import 'dart:io';

import 'package:easy_tv_live/channel_drawer_page.dart';
import 'package:easy_tv_live/mobile_video_widget.dart';
import 'package:easy_tv_live/subscribe/subscribe_page.dart';
import 'package:easy_tv_live/table_video_widget.dart';
import 'package:easy_tv_live/tv/tv_page.dart';
import 'package:easy_tv_live/util/env_util.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:easy_tv_live/util/m3u_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sp_util/sp_util.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();
  LogUtil.init(isDebug: false, tag: 'EasyTV');
  await SpUtil.getInstance();
  runApp(const MyApp());
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '极简TV',
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Kaiti', useMaterial3: true),
      routes: {'subScribe': (BuildContext context) => const SubScribePage()},
      home: const LiveHomePage(),
      builder: EasyLoading.init(),
    );
  }
}

class LiveHomePage extends StatefulWidget {
  const LiveHomePage({super.key});

  @override
  State<LiveHomePage> createState() => _LiveHomePageState();
}

class _LiveHomePageState extends State<LiveHomePage> {
  String toastString = '正在加载';

  String _sourceName = '默认数据源';

  Map<String, dynamic>? _videoMap;

  String _group = '';
  String _channel = '';
  int _sourceIndex = 0;

  VideoPlayerController? _playerController;

  bool isBuffering = false;

  bool isPlaying = false;
  double aspectRatio = 1.78;

  _playVideo() async {
    setState(() {
      toastString = '线路${_sourceIndex + 1}-正在播放：$_channel';
    });
    final url = _videoMap![_group][_channel][_sourceIndex].toString();
    debugPrint('正在播放:::$url');
    if (_playerController != null) {
      await _playerController?.dispose();
      _playerController = null;
      setState(() {});
    }
    _playerController = VideoPlayerController.networkUrl(Uri.parse(url),
        formatHint: VideoFormat.hls,
        videoPlayerOptions: VideoPlayerOptions(
          allowBackgroundPlayback: false,
          mixWithOthers: false,
          webOptions:
              const VideoPlayerWebOptions(controls: VideoPlayerWebOptionsControls.enabled()),
        ))
      ..setVolume(1.0);

    try {
      await _playerController!.initialize();
      _playerController!.play();
      setState(() {
        toastString = '正在加载';
        aspectRatio = _playerController!.value.aspectRatio;
      });
    } catch (e) {
      final channels = _videoMap![_group][_channel];
      _sourceIndex += 1;
      if (_sourceIndex > channels.length - 1) {
        _sourceIndex = 0;
        setState(() {
          toastString = '此视频无法播放，请更换其它频道';
        });
      } else {
        setState(() {
          toastString = '切换线路${_sourceIndex + 1}...';
        });
        Future.delayed(const Duration(seconds: 2), () => _playVideo());
        return;
      }
    }
    _playerController!.addListener(() {
      if (_playerController!.value.hasError) {
        final channels = _videoMap![_group][_channel];
        _sourceIndex += 1;
        if (_sourceIndex > channels.length - 1) {
          _sourceIndex = 0;
          setState(() {
            toastString = '出错了，尝试重新连接...';
          });
        } else {
          setState(() {
            toastString = '切换线路${_sourceIndex + 1}...';
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
    });
  }

  _onTapChannel(String group, String channel) {
    _group = group;
    _channel = channel;
    _sourceIndex = 0;
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
    _parseData();
  }

  @override
  dispose() {
    WakelockPlus.disable();
    _playerController?.dispose();
    super.dispose();
  }

  _parseData() async {
    final resMap = await M3uUtil.getDefaultM3uData((String sourceName) {
      _sourceName = sourceName;
    });
    _videoMap = resMap;
    _group = _videoMap!.keys.first.toString();
    _channel = Map.from(_videoMap![_group]).keys.first;
    _sourceIndex = 0;
    _playVideo();
  }

  @override
  Widget build(BuildContext context) {
    if (EnvUtil.isTV()) {
      return TvPage(
        videoMap: _videoMap,
        channelName: _channel,
        groupName: _group,
        onTapChannel: _onTapChannel,
        sourceName: _sourceName,
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
              channelName: _channel,
              groupName: _group,
              onTapChannel: _onTapChannel,
              isLandscape: false,
            ),
          );
        },
        landscape: (context) {
          return ResponsiveBuilder(builder: (context, sizingInformation) {
            debugPrint('sizingInformation::::${sizingInformation.deviceScreenType.name}');
            if (sizingInformation.isDesktop) {
              return const TvPage();
            } else {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
              return WillPopScope(
                onWillPop: () async {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight
                  ]);
                  return false;
                },
                child: Scaffold(
                  drawer: ChannelDrawerPage(
                      videoMap: _videoMap,
                      channelName: _channel,
                      groupName: _group,
                      onTapChannel: _onTapChannel,
                      isLandscape: true),
                  drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.3,
                  drawerScrimColor: Colors.transparent,
                  body: TableVideoWidget(
                      toastString: toastString,
                      controller: _playerController,
                      isBuffering: isBuffering,
                      isPlaying: isPlaying,
                      aspectRatio: aspectRatio,
                      changeChannelSources: _changeChannelSources,
                      isLandscape: true),
                ),
              );
            }
          });
        },
      ),
    );
  }

  Future<void> _changeChannelSources() async {
    List sources = _videoMap![_group][_channel];
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
                    return OutlinedButton(
                        autofocus: _sourceIndex == index,
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            side: BorderSide(
                                color: _sourceIndex == index ? Colors.red : Colors.white)),
                        child: Text(
                          '线路${index + 1}',
                          style: TextStyle(
                              fontSize: 12,
                              color: _sourceIndex == index ? Colors.red : Colors.white),
                        ),
                        onFocusChange: (focus) {
                          if (focus && _sourceIndex != index) {
                            Future.delayed(const Duration(microseconds: 300),
                                () => Navigator.pop(context, index));
                          }
                        },
                        onPressed: () {
                          Navigator.pop(context, index);
                        });
                  })),
            ),
          );
        });
    if (selectedIndex != null && _sourceIndex != selectedIndex) {
      debugPrint('切换线路:====线路${_sourceIndex + 1}');
      _sourceIndex = selectedIndex;
      _playVideo();
    }
  }
}
