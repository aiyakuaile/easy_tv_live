import 'package:easy_tv_live/channel_drawer_page.dart';
import 'package:easy_tv_live/table_video_widget.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MobileVideoWidget extends StatefulWidget {
  final VideoPlayerController? controller;
  final GestureTapCallback? changeChannelSources;
  final String? toastString;
  final bool isLandscape;
  final Widget drawChild;
  final bool isBuffering;
  final bool isPlaying;
  final double aspectRatio;
  final GestureTapCallback onChangeSubSource;
  const MobileVideoWidget({
    Key? key,
    required this.controller,
    required this.drawChild,
    required this.isBuffering,
    required this.isPlaying,
    required this.aspectRatio,
    required this.onChangeSubSource,
    this.toastString,
    this.changeChannelSources,
    this.isLandscape = true,
  }) : super(key: key);

  @override
  State<MobileVideoWidget> createState() => _MobileVideoWidgetState();
}

class _MobileVideoWidgetState extends State<MobileVideoWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('极简TV'),
        actions: [
          TextButton(
              onPressed: () async {
                final isPlayer = widget.controller?.value.isPlaying ?? false;
                if (isPlayer) {
                  widget.controller!.pause();
                }
                final res = await Navigator.of(context).pushNamed('subScribe');
                if (isPlayer) {
                  widget.controller!.play();
                }
                LogUtil.v('刷新======$res');
                if (res == true) {
                  lastTimeOffset = 0;
                  lastTimeChannelOffset = 0;
                  widget.onChangeSubSource();
                }
              },
              child: const Text('频道订阅'))
        ],
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: TableVideoWidget(
              controller: widget.controller,
              toastString: widget.toastString,
              isLandscape: false,
              aspectRatio: widget.aspectRatio,
              isBuffering: widget.isBuffering,
              isPlaying: widget.isPlaying,
            ),
          ),
          Flexible(child: widget.drawChild)
        ],
      ),
    );
  }
}
