import 'dart:async';

import 'package:easy_tv_live/tv/tv_setting_page.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/widget/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sp_util/sp_util.dart';
import 'package:video_player/video_player.dart';

import '../channel_drawer_page.dart';
import '../entity/playlist_model.dart';
import '../util/log_util.dart';
import '../widget/video_hold_bg.dart';

class TvPage extends StatefulWidget {
  final PlaylistModel? videoMap;
  final PlayModel? playModel;
  final Function(PlayModel? newModel)? onTapChannel;

  final VideoPlayerController? controller;
  final Future<void> Function()? changeChannelSources;
  final GestureTapCallback? onChangeSubSource;
  final String? toastString;
  final bool isLandscape;
  final bool isBuffering;
  final bool isPlaying;
  final double aspectRatio;

  const TvPage({
    super.key,
    this.videoMap,
    this.onTapChannel,
    this.controller,
    this.playModel,
    this.changeChannelSources,
    this.onChangeSubSource,
    this.toastString,
    this.isLandscape = false,
    this.isBuffering = false,
    this.isPlaying = false,
    this.aspectRatio = 16 / 9,
  });

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  final _videoNode = FocusNode();

  bool _debounce = true;
  Timer? _timer;

  Future<bool?> _openAddSource() async {
    return Navigator.push<bool>(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const TvSettingPage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, -1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  _focusEventHandle(BuildContext context, KeyEvent e) async {
    final isUpKey = e is KeyUpEvent;
    if (!isUpKey) return;
    if (!_debounce) return;
    _debounce = false;
    _timer = Timer(const Duration(milliseconds: 500), () {
      _debounce = true;
      _timer?.cancel();
      _timer = null;
    });

    switch (e.logicalKey) {
      case LogicalKeyboardKey.arrowRight:
        LogUtil.v('按了右键');
        break;
      case LogicalKeyboardKey.arrowLeft:
        LogUtil.v('按了左键');
        break;
      case LogicalKeyboardKey.arrowUp:
        LogUtil.v('按了上键');
        _videoNode.unfocus();
        await widget.changeChannelSources?.call();
        Future.delayed(const Duration(seconds: 1), () => _videoNode.requestFocus());
        break;
      case LogicalKeyboardKey.arrowDown:
        LogUtil.v('按了下键');
        widget.controller?.pause();
        _videoNode.unfocus();
        await _openAddSource();
        final m3uData = SpUtil.getString('m3u_cache', defValue: '')!;
        if (m3uData == '') {
          widget.onChangeSubSource?.call();
        } else {
          widget.controller?.play();
        }
        Future.delayed(const Duration(seconds: 1), () => _videoNode.requestFocus());
        break;
      case LogicalKeyboardKey.select:
        if (widget.toastString == 'UNKNOWN') {
          widget.onChangeSubSource?.call();
          return;
        }

        LogUtil.v('按了确认键:::isPlaying:${widget.isPlaying}:::video:value:${widget.controller?.value}');
        if (widget.controller!.value.isInitialized == true &&
            widget.controller!.value.isPlaying == false &&
            widget.controller!.value.isBuffering == false) {
          widget.controller?.play();
          return;
        }
        LogUtil.v('确认键:::打开频道列表');
        if (!Scaffold.of(context).isDrawerOpen) {
          Scaffold.of(context).openDrawer();
        }
        break;
      case LogicalKeyboardKey.goBack:
        LogUtil.v('按了返回键');
        break;
      case LogicalKeyboardKey.contextMenu:
        LogUtil.v('按了菜单键');
        if (!Scaffold.of(context).isDrawerOpen) {
          Scaffold.of(context).openDrawer();
        }
        break;
      case LogicalKeyboardKey.audioVolumeUp:
        LogUtil.v('按了音量加键');
        break;
      case LogicalKeyboardKey.audioVolumeDown:
        LogUtil.v('按了音量减键');
        break;
      case LogicalKeyboardKey.f5:
        LogUtil.v('按了语音键');
        break;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _videoNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: ChannelDrawerPage(
        videoMap: widget.videoMap,
        playModel: widget.playModel,
        onTapChannel: widget.onTapChannel,
        isLandscape: true,
      ),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.3,
      drawerScrimColor: Colors.transparent,
      body: Builder(builder: (context) {
        return KeyboardListener(
          focusNode: _videoNode,
          autofocus: true,
          onKeyEvent: (KeyEvent e) => _focusEventHandle(context, e),
          child: widget.toastString == 'UNKNOWN'
              ? EmptyPage(onRefresh: () => widget.onChangeSubSource?.call())
              : Container(
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: widget.controller?.value.isInitialized ?? false
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
                                  child: const Icon(Icons.play_circle_outline, color: Colors.white, size: 50)),
                            if (widget.isBuffering) const SpinKitSpinningLines(color: Colors.white),
                            if (Scaffold.of(context).isDrawerOpen)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Column(
                                  children: [
                                    Text(DateUtil.formatDate(DateTime.now(), format: 'HH:mm')),
                                    Text(DateUtil.formatDate(DateTime.now(), format: 'yyyy年MM月dd日')),
                                  ],
                                ),
                              )
                          ],
                        )
                      : VideoHoldBg(toastString: widget.toastString),
                ),
        );
      }),
    );
  }
}
