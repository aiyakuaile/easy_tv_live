import 'package:easy_tv_live/channel_drawer_page.dart';
import 'package:easy_tv_live/empty_page.dart';
import 'package:easy_tv_live/setting_page.dart';
import 'package:easy_tv_live/table_video_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'util/check_version_util.dart';

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
    Future.delayed(const Duration(milliseconds: 300), () {
      CheckVersionUtil.checkVersion(context, false, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('极简TV'),
        leading: IconButton(
            onPressed: () async {
              widget.controller?.pause();
              await Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) {
                    return const SettingPage();
                  },
                ),
              );
              widget.controller?.play();
            },
            icon: Image.asset(
              'assets/images/github.png',
              width: 30,
            )),
        actions: [
          TextButton(
              onPressed: () async {
                final isPlaying = widget.controller?.value.isPlaying ?? false;
                if (isPlaying) {
                  widget.controller?.pause();
                }
                final res = await Navigator.of(context).pushNamed('subScribe');
                widget.controller?.play();
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
          Flexible(child: widget.toastString == 'UNKNOWN' ? EmptyPage(onRefresh: widget.onChangeSubSource) : widget.drawChild)
        ],
      ),
    );
  }
}
