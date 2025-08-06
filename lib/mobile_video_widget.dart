import 'package:easy_tv_live/router_keys.dart';
import 'package:easy_tv_live/setting/subscribe_page.dart';
import 'package:easy_tv_live/table_video_widget.dart';
import 'package:easy_tv_live/util/m3u_util.dart';
import 'package:easy_tv_live/widget/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:window_manager/window_manager.dart';

import 'generated/l10n.dart';
import 'util/env_util.dart';

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
  final GestureTapCallback onPreviousChannel;
  final GestureTapCallback onNextChannel;
  final GestureTapCallback onSwitchSource;

  const MobileVideoWidget({
    super.key,
    required this.controller,
    required this.drawChild,
    required this.isBuffering,
    required this.isPlaying,
    required this.aspectRatio,
    // 数据源改变
    required this.onChangeSubSource,
    required this.onPreviousChannel,
    required this.onNextChannel,
    required this.onSwitchSource,
    this.toastString,
    // 线路切换
    this.changeChannelSources,
    this.isLandscape = true,
  });

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
        leading: IconButton(
          icon: const Icon(Icons.qr_code_scanner),
          onPressed: () async {
            widget.controller?.pause();
            final res = await Navigator.of(context).pushNamed(RouterKeys.settingQrScan);
            if (res != null && res != '') {
              widget.controller?.pause();
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    final ip = Uri.parse(res.toString()).host;
                    return SubScribePage(remoteIp: ip, isTV: false);
                  },
                ),
              );
              final isChange = await M3uUtil.isChangeChannelLink();
              if (isChange) {
                widget.onChangeSubSource.call();
              } else {
                widget.controller?.play();
              }
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (!EnvUtil.isMobile) {
                windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: false);
              }
              final isPlaying = widget.controller?.value.isPlaying ?? false;
              if (isPlaying) {
                widget.controller?.pause();
              }
              await Navigator.of(context).pushNamed(RouterKeys.subScribe);
              final isChange = await M3uUtil.isChangeChannelLink();
              if (isChange) {
                widget.onChangeSubSource.call();
              } else {
                widget.controller?.play();
              }
              if (!EnvUtil.isMobile) {
                windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: true);
              }
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              if (!EnvUtil.isMobile) {
                windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: false);
              }
              widget.controller?.pause();
              await Navigator.of(context).pushNamed(RouterKeys.setting);
              widget.controller?.play();
              if (!EnvUtil.isMobile) {
                windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: true);
              }
            },
            icon: const Icon(Icons.settings_outlined),
          ),
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
              changeChannelSources: widget.changeChannelSources,
              onChangeSubSource: widget.onChangeSubSource,
              drawerIsOpen: false,
              onPreviousChannel: widget.onPreviousChannel,
              onNextChannel: widget.onNextChannel,
              onSwitchSource: widget.onSwitchSource,
            ),
          ),
          Flexible(child: widget.toastString == 'UNKNOWN' ? EmptyPage(onRefresh: widget.onChangeSubSource) : widget.drawChild),
        ],
      ),
    );
  }
}
