import 'package:easy_tv_live/router_keys.dart';
import 'package:easy_tv_live/table_video_widget.dart';
import 'package:easy_tv_live/widget/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:window_manager/window_manager.dart';

import 'generated/l10n.dart';

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
    // 数据源改变
    required this.onChangeSubSource,
    this.toastString,
    // 线路切换
    this.changeChannelSources,
    this.isLandscape = true,
  }) : super(key: key);

  @override
  State<MobileVideoWidget> createState() => _MobileVideoWidgetState();
}

class _MobileVideoWidgetState extends State<MobileVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(S.current.appName),
        actions: [
          IconButton(
              onPressed: () async {
                windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: false);
                final isPlaying = widget.controller?.value.isPlaying ?? false;
                if (isPlaying) {
                  widget.controller?.pause();
                }
                final res = await Navigator.of(context).pushNamed(RouterKeys.subScribe);
                widget.controller?.play();
                if (res == true) {
                  widget.onChangeSubSource();
                }
                windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: true);
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: false);
                widget.controller?.pause();
                await Navigator.of(context).pushNamed(RouterKeys.setting);
                widget.controller?.play();
                windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: true);
              },
              icon: const Icon(Icons.settings_outlined)),
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
