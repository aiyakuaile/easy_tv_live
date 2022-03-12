import 'package:easy_tv_live/channel_drawer_page.dart';
import 'package:easy_tv_live/table_video_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MobileVideoWidget extends StatefulWidget {
  final VideoPlayerController? controller;
  final GestureTapCallback? changeChannelSources;
  final String? toastString;
  final bool isLandscape;
  final Widget drawChild;
  final bool isBuffering;
  final ValueChanged<int> onChangeSubSource;
  final int subSourceIndex;
  const MobileVideoWidget(
      {Key? key,
      required this.controller,
      required this.drawChild,
      required this.isBuffering,
      required this.onChangeSubSource,
      this.toastString,
      this.changeChannelSources,
      this.isLandscape = true,
       this.subSourceIndex = 0
      })
      : super(key: key);

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
        title: const Text('极简TV'),
        actions: [
          TextButton(onPressed: (){
            lastTimeOffset = 0;
            lastTimeChannelOffset = 0;
            widget.onChangeSubSource(widget.subSourceIndex == 0?1:0);
          }, child: Text(widget.subSourceIndex == 0?'订阅1':'订阅2'))
        ],
      ),
      body: Column(
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: TableVideoWidget(
                  controller: widget.controller,
                  toastString: widget.toastString,
                  isLandscape: false,
                  isBuffering: widget.isBuffering,
              )),
          Flexible(child: widget.drawChild)
        ],
      ),
    );
  }
}
