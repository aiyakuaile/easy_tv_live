import 'package:easy_tv_live/video_hold_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';
import 'package:volume_controller/volume_controller.dart';

class TableVideoWidget extends StatefulWidget {
  final VideoPlayerController? controller;
  final GestureTapCallback? changeChannelSources;
  final String? toastString;
  final bool isLandscape;
  final bool isBuffering;
  final bool isPlaying;
  const TableVideoWidget(
      {Key? key,
      required this.controller,
      required this.isBuffering,
      required this.isPlaying,
      this.toastString,
      this.changeChannelSources,
      this.isLandscape = true})
      : super(key: key);

  @override
  State<TableVideoWidget> createState() => _TableVideoWidgetState();
}

class _TableVideoWidgetState extends State<TableVideoWidget>{
  bool _isShowMenuBar = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.isLandscape
              ? () {
                  setState(() {
                    _isShowMenuBar = !_isShowMenuBar;
                  });
                }
              : null,
          onDoubleTap: () {
            if (widget.isPlaying) {
              widget.controller?.pause();
            } else {
              widget.controller?.play();
            }
          },
          onVerticalDragUpdate: (DragUpdateDetails details){
            double volume = 1.0 - details.localPosition.dy/(context.size?.height ?? 1.0);
            if(volume <= 0){
              volume = 0;
            }else if(volume>1.0){
              volume = 1.0;
            }
            debugPrint('details.delta.dy====$volume');
            VolumeController().setVolume(volume,showSystemUI: true);

          },
          child: Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: widget.controller?.value.isInitialized ?? false
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: widget.controller!.value.aspectRatio,
                        child: VideoPlayer(widget.controller!),
                      ),
                      if (!widget.isPlaying)
                        GestureDetector(
                            onTap: () {
                              widget.controller?.play();
                            },
                            child: const Icon(Icons.play_circle_outline,
                                color: Colors.white, size: 50)),
                      if (widget.isBuffering)
                        const SpinKitSpinningLines(color: Colors.white)
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
                    GestureDetector(
                      onTap: () {
                        SystemChrome.setPreferredOrientations(
                            [DeviceOrientation.portraitUp]);
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
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight
                ]);
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
