import 'dart:async';

import 'package:easy_tv_live/util/m3u_util.dart';
import 'package:easy_tv_live/widget/date_position_widget.dart';
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

  bool _drawerIsOpen = false;

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
        await M3uUtil.openAddSource(context);
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
      onDrawerChanged: (bool isOpen) {
        setState(() {
          _drawerIsOpen = isOpen;
        });
      },
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      widget.controller?.value.isInitialized == true
                          ? AspectRatio(
                              aspectRatio: widget.aspectRatio,
                              child: SizedBox(
                                width: double.infinity,
                                child: VideoPlayer(widget.controller!),
                              ),
                            )
                          : VideoHoldBg(toastString: _drawerIsOpen ? '' : widget.toastString),
                      if (_drawerIsOpen) const DatePositionWidget(),
                      if (!widget.isPlaying && !_drawerIsOpen)
                        GestureDetector(
                            onTap: () {
                              widget.controller?.play();
                            },
                            child: const Icon(Icons.play_circle_outline, color: Colors.white, size: 50)),
                      if (widget.isBuffering && !_drawerIsOpen) const SpinKitSpinningLines(color: Colors.white),
                    ],
                  ),
                ),
        );
      }),
    );
  }
}
