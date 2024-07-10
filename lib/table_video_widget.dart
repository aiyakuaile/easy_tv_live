import 'package:easy_tv_live/video_hold_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:video_player/video_player.dart';

class TableVideoWidget extends StatefulWidget {
  final VideoPlayerController? controller;
  final GestureTapCallback? changeChannelSources;
  final String? toastString;
  final bool isLandscape;
  final bool isBuffering;
  final bool isPlaying;
  final double aspectRatio;
  const TableVideoWidget(
      {Key? key,
      required this.controller,
      required this.isBuffering,
      required this.isPlaying,
      required this.aspectRatio,
      this.toastString,
      this.changeChannelSources,
      this.isLandscape = true})
      : super(key: key);

  @override
  State<TableVideoWidget> createState() => _TableVideoWidgetState();
}

class _TableVideoWidgetState extends State<TableVideoWidget> {
  bool _isShowMenuBar = true;

  double _volume = 0.5;
  double _brightness = 0.5;

  // 0
  // 1: 音量
  // 2: 亮度
  int _isControllerType = 0;

  @override
  void initState() {
    _loadSystemData();
    super.initState();
  }

  _loadSystemData() async {
    _brightness = await ScreenBrightness().current;
    _volume = await FlutterVolumeController.getVolume() ?? 0.5;
    await FlutterVolumeController.updateShowSystemUI(false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.isLandscape
              ? () {
                  _isShowMenuBar = !_isShowMenuBar;
                  if (!_isShowMenuBar) {
                    _isControllerType = 0;
                  }
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
          child: Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: widget.controller!.value.isInitialized
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: widget.aspectRatio,
                        child: SizedBox(
                          width: double.infinity,
                          child: VideoPlayer(widget.controller!),
                        ),
                      ),
                      if (!widget.isPlaying)
                        GestureDetector(
                            onTap: () {
                              widget.controller?.play();
                            },
                            child: const Icon(Icons.play_circle_outline,
                                color: Colors.white, size: 50)),
                      if (widget.isBuffering) const SpinKitSpinningLines(color: Colors.white)
                    ],
                  )
                : VideoHoldBg(toastString: widget.toastString),
          ),
        ),
        if (widget.isLandscape)
          AnimatedPositioned(
              left: 20,
              right: 20,
              bottom: _isShowMenuBar || !widget.isPlaying ? 20 : -50,
              duration: const Duration(milliseconds: 100),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    const Spacer(),
                    IconButton(
                        tooltip: '频道列表',
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.black87,
                            side: const BorderSide(color: Colors.white)),
                        icon: const Icon(
                          Icons.list_alt,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        }),
                    const SizedBox(width: 12),
                    IconButton(
                        tooltip: '切换线路',
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.black87,
                            side: const BorderSide(color: Colors.white)),
                        icon: const Icon(
                          Icons.legend_toggle,
                          color: Colors.white,
                        ),
                        onPressed: widget.changeChannelSources),
                    const SizedBox(width: 12),
                    IconButton(
                        tooltip: '调节亮度',
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.black87,
                            side: const BorderSide(color: Colors.white)),
                        icon: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.light_mode,
                              color: Colors.white,
                            ),
                            if (_isControllerType == 2)
                              SizedBox(
                                width: 200,
                                height: 20,
                                child: Slider(
                                    value: _brightness,
                                    max: 1.0,
                                    min: .0,
                                    onChanged: (value) {
                                      ScreenBrightness().setScreenBrightness(value);
                                      setState(() {
                                        _brightness = value;
                                      });
                                    }),
                              )
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            _isControllerType = 2;
                          });
                        }),
                    const SizedBox(width: 12),
                    IconButton(
                        tooltip: '调节音量',
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.black87,
                            side: const BorderSide(color: Colors.white)),
                        icon: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.volume_up_outlined,
                              color: Colors.white,
                            ),
                            if (_isControllerType == 1)
                              SizedBox(
                                width: 200,
                                height: 20,
                                child: Slider(
                                    value: _volume,
                                    max: 1.0,
                                    min: .0,
                                    onChanged: (value) {
                                      FlutterVolumeController.setVolume(value);
                                      setState(() {
                                        _volume = value;
                                      });
                                    }),
                              )
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            _isControllerType = 1;
                          });
                        }),
                    const SizedBox(width: 12),
                    IconButton(
                      tooltip: '退出全屏',
                      onPressed: () {
                        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                      },
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.black87,
                          side: const BorderSide(color: Colors.white)),
                      icon: const Icon(
                        Icons.fullscreen_exit,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )),
        if (!widget.isLandscape)
          Positioned(
            right: 15,
            bottom: 15,
            child: GestureDetector(
              onTap: () {
                SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
              },
              child: Image.asset(
                'assets/images/video_fill.png',
                width: 30,
                gaplessPlayback: true,
              ),
            ),
          )
      ],
    );
  }
}
