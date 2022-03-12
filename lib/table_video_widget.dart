import 'package:easy_tv_live/video_hold_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class TableVideoWidget extends StatefulWidget {
  final VideoPlayerController? controller;
  final GestureTapCallback? changeChannelSources;
  final String? toastString;
  final bool isLandscape;
  final bool isBuffering;
  const TableVideoWidget(
      {Key? key,
      required this.controller,
      required this.isBuffering,
      this.toastString,
      this.changeChannelSources,
      this.isLandscape = true})
      : super(key: key);

  @override
  State<TableVideoWidget> createState() => _TableVideoWidgetState();
}

class _TableVideoWidgetState extends State<TableVideoWidget> {
  bool _isShowMenuBar = true;
  bool _isLock = false;
  late bool _isPlaying = widget.controller?.value.isPlaying ?? false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          color: Colors.black,
          child: widget.controller?.value.isInitialized ?? false
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isShowMenuBar = !_isShowMenuBar;
                        });
                      },
                      onDoubleTap: () {
                        if (_isPlaying) {
                          widget.controller?.pause();
                        } else {
                          widget.controller?.play();
                        }
                        _isPlaying = !_isPlaying;
                        setState(() {});
                      },
                      child: AspectRatio(
                        aspectRatio: widget.controller!.value.aspectRatio,
                        child: VideoPlayer(widget.controller!),
                      ),
                    ),
                    if (!_isPlaying)
                      GestureDetector(
                          onTap: () {
                            widget.controller?.play();
                            setState(() {
                              _isPlaying = true;
                            });
                          },
                          child: const Icon(Icons.play_circle_outline,
                              color: Colors.white, size: 50)),
                    if (widget.isBuffering)
                      const SpinKitSpinningLines(color: Colors.white)
                  ],
                )
              : VideoHoldBg(toastString: widget.toastString),
        ),
        if (widget.isLandscape)
          AnimatedPositioned(
              left: 20,
              right: 20,
              bottom: _isShowMenuBar ? 20 : -50,
              duration: const Duration(milliseconds: 100),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    const Spacer(),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            side: const BorderSide(color: Colors.white)),
                        child: const Text(
                          '频道列表',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        }),
                    const SizedBox(width: 20),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            side: const BorderSide(color: Colors.white)),
                        child: const Text(
                          '切换源',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: widget.changeChannelSources),
                    const SizedBox(width: 20),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: _isLock
                                ? Colors.red.withOpacity(0.4)
                                : Colors.black87,
                            side: const BorderSide(color: Colors.white)),
                        child: Text(
                          _isLock ? '已锁定' : '锁定',
                          style: const TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_isLock) {
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.landscapeLeft,
                              DeviceOrientation.landscapeRight,
                              DeviceOrientation.portraitUp
                            ]);
                          } else {
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.landscapeLeft,
                              DeviceOrientation.landscapeRight
                            ]);
                          }
                          setState(() {
                            _isLock = !_isLock;
                          });
                        }),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        SystemChrome.setPreferredOrientations(
                            [DeviceOrientation.portraitUp,DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
                      },
                      child: Center(
                        child: Image.asset(
                          'assets/images/video_scale.png',
                          width: 44,
                          height: 44,
                          gaplessPlayback: true,
                        ),
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
                  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
                },
                child: Image.asset(
                  'assets/images/video_fill.png',
                  width: 30,
                  gaplessPlayback: true,
                ),
              ))
      ],
    );
  }
}
