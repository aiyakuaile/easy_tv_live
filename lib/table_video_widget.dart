import 'package:easy_tv_live/util/env_util.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:easy_tv_live/util/m3u_util.dart';
import 'package:easy_tv_live/widget/date_position_widget.dart';
import 'package:easy_tv_live/widget/video_hold_bg.dart';
import 'package:easy_tv_live/widget/volume_brightness_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';
import 'package:window_manager/window_manager.dart';

import 'generated/l10n.dart';

class TableVideoWidget extends StatefulWidget {
  final VideoPlayerController? controller;
  final GestureTapCallback? changeChannelSources;
  final String? toastString;
  final bool isLandscape;
  final bool isBuffering;
  final bool isPlaying;
  final double aspectRatio;
  final bool drawerIsOpen;
  final GestureTapCallback onChangeSubSource;
  final GestureTapCallback onPreviousChannel;
  final GestureTapCallback onNextChannel;
  final GestureTapCallback onSwitchSource;
  const TableVideoWidget({
    super.key,
    required this.controller,
    required this.isBuffering,
    required this.isPlaying,
    required this.aspectRatio,
    required this.drawerIsOpen,
    required this.onChangeSubSource,
    required this.onPreviousChannel,
    required this.onNextChannel,
    required this.onSwitchSource,
    this.toastString,
    this.changeChannelSources,
    this.isLandscape = true,
  });

  @override
  State<TableVideoWidget> createState() => _TableVideoWidgetState();
}

class _TableVideoWidgetState extends State<TableVideoWidget> with WindowListener {
  bool _isShowMenuBar = true;

  bool _isShowOpView = true;

  // Timer? _timer;
  @override
  void initState() {
    super.initState();
    if (!EnvUtil.isMobile) windowManager.addListener(this);
  }

  @override
  void dispose() {
    if (!EnvUtil.isMobile) windowManager.removeListener(this);
    // _timer?.cancel();
    super.dispose();
  }

  // @override
  // void onWindowEnterFullScreen() {
  //   super.onWindowEnterFullScreen();
  //   windowManager.setTitleBarStyle(TitleBarStyle.normal, windowButtonVisibility: true);
  // }
  //
  // @override
  // void onWindowLeaveFullScreen() {
  //   windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: false);
  // }

  @override
  void onWindowResize() async {
    final size = await windowManager.getSize();
    await windowManager.setAspectRatio(16/9);
    if (size.width < 600) {
      if (!_isShowOpView) return;
      _isShowOpView = false;
      setState(() {});
    } else {
      if (_isShowOpView) return;
      _isShowOpView = true;
      setState(() {});
    }
  }

  _pushSettingPage(BuildContext context) async {
    widget.controller?.pause();
    await M3uUtil.openAddSource(context);
    final isChange = await M3uUtil.isChangeChannelLink();
    if (isChange) {
      widget.onChangeSubSource.call();
    } else {
      widget.controller?.play();
    }
  }

  _pushChannelDrawer(BuildContext context) {
    setState(() {
      _isShowMenuBar = false;
    });
    Scaffold.of(context).openDrawer();
  }

  _nextChannel() {
    setState(() {
      _isShowMenuBar = false;
    });
    LogUtil.v('下一个：：：：');
    widget.onNextChannel();
  }

  _previousChannel() {
    setState(() {
      _isShowMenuBar = false;
    });
    widget.onPreviousChannel();
  }

  _toggleLine() {
    setState(() {
      _isShowMenuBar = false;
    });
    LogUtil.v('切换源：：：：');
    widget.onSwitchSource();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: widget.isLandscape
              ? () {
                  _isShowMenuBar = !_isShowMenuBar;
                  setState(() {});
                }
              : null,
          onDoubleTap: () {
            if (widget.isPlaying) {
              widget.controller?.pause();
            } else {
              widget.controller?.play();
            }
          },
          onHover: (bool isHover) {
            // if (isHover) {
            //   _timer?.cancel();
            //   windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: true);
            //   _timer = Timer(const Duration(seconds: 8), () {
            //     windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: false);
            //   });
            // }
          },
          child: Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: widget.controller?.value.isInitialized ?? false
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: widget.aspectRatio,
                        child: SizedBox(width: double.infinity, child: VideoPlayer(widget.controller!)),
                      ),
                      if (!widget.isPlaying && !widget.drawerIsOpen)
                        GestureDetector(
                          onTap: () {
                            widget.controller?.play();
                          },
                          child: const Icon(Icons.play_circle_outline, color: Colors.white, size: 50),
                        ),
                      if (widget.isBuffering && !widget.drawerIsOpen) const SpinKitSpinningLines(color: Colors.white),
                    ],
                  )
                : VideoHoldBg(toastString: widget.drawerIsOpen ? '' : widget.toastString),
          ),
        ),
        if (_isShowOpView) ...[
          if (widget.drawerIsOpen || (!widget.drawerIsOpen && _isShowMenuBar && widget.isLandscape)) const DatePositionWidget(),
          if (widget.isLandscape)
            Builder(
              builder: (BuildContext context) {
                return Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: 80,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => _pushSettingPage(context),
                                child: Tooltip(
                                  message: '进入设置',
                                  child: SizedBox(width: 80, height: MediaQuery.of(context).size.height),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => _pushChannelDrawer(context),
                                child: Tooltip(
                                  message: '打开频道列表',
                                  child: SizedBox(width: 80, height: MediaQuery.of(context).size.height),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: const VolumeBrightnessWidget()),
                    Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: 80,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Expanded(
                              child: Tooltip(
                                message: '上一个节目',
                                child: InkWell(onTap: _previousChannel),
                              ),
                            ),
                            Expanded(
                              child: Tooltip(
                                message: '切换线路',
                                child: InkWell(onTap: _toggleLine),
                              ),
                            ),
                            Expanded(
                              child: Tooltip(
                                message: '下一个节目',
                                child: InkWell(onTap: _nextChannel),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          if (widget.isLandscape && !widget.drawerIsOpen)
            AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: _isShowMenuBar || !widget.isPlaying ? 20 : -50,
              duration: const Duration(milliseconds: 100),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      tooltip: '进入设置',
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.white),
                      ),
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () async {
                        widget.controller?.pause();
                        await M3uUtil.openAddSource(context);
                        final isChange = await M3uUtil.isChangeChannelLink();
                        if (isChange) {
                          widget.onChangeSubSource.call();
                        } else {
                          widget.controller?.play();
                        }
                      },
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      tooltip: S.current.tipChannelList,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.white),
                      ),
                      icon: const Icon(Icons.list_alt, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _isShowMenuBar = false;
                        });
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      tooltip: S.current.tipChangeLine,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.white),
                      ),
                      icon: const Icon(Icons.legend_toggle, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _isShowMenuBar = false;
                        });
                        widget.changeChannelSources?.call();
                      },
                    ),
                    if (EnvUtil.isMobile) const SizedBox(width: 12),
                    if (EnvUtil.isMobile)
                      IconButton(
                        tooltip: S.current.portrait,
                        onPressed: () async {
                          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black87,
                          side: const BorderSide(color: Colors.white),
                        ),
                        icon: const Icon(Icons.screen_rotation, color: Colors.white),
                      ),
                    if (!EnvUtil.isMobile) const SizedBox(width: 12),
                    if (!EnvUtil.isMobile)
                      IconButton(
                        tooltip: S.current.fullScreen,
                        onPressed: () async {
                          final isFullScreen = await windowManager.isFullScreen();
                          LogUtil.v('isFullScreen:::::$isFullScreen');
                          windowManager.setFullScreen(!isFullScreen);
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black87,
                          side: const BorderSide(color: Colors.white),
                        ),
                        icon: FutureBuilder<bool>(
                          future: windowManager.isFullScreen(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Icon(snapshot.data! ? Icons.close_fullscreen : Icons.fit_screen_outlined, color: Colors.white);
                            } else {
                              return const Icon(Icons.fit_screen_outlined, color: Colors.white);
                            }
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          if (!widget.isLandscape)
            Positioned(
              right: 15,
              bottom: 15,
              child: IconButton(
                tooltip: S.current.landscape,
                onPressed: () async {
                  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
                },
                style: IconButton.styleFrom(backgroundColor: Colors.black45, iconSize: 20),
                icon: const Icon(Icons.screen_rotation, color: Colors.white),
              ),
            ),
        ],
      ],
    );
  }
}
