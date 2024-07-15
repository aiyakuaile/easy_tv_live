import 'dart:async';

import 'package:easy_tv_live/subscribe/subscribe_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

import '../channel_drawer_page.dart';
import '../video_hold_bg.dart';

class TvPage extends StatefulWidget {
  final Map<String, dynamic>? videoMap;
  final String? channelName;
  final String? groupName;
  final String? sourceName;
  final Function(String group, String channel)? onTapChannel;

  final VideoPlayerController? controller;
  final Future<void> Function()? changeChannelSources;
  final GestureTapCallback? onChangeSubSource;
  final String? toastString;
  final bool isLandscape;
  final bool isBuffering;
  final bool isPlaying;
  final double aspectRatio;

  const TvPage({
    Key? key,
    this.videoMap,
    this.groupName,
    this.channelName,
    this.sourceName,
    this.onTapChannel,
    this.controller,
    this.changeChannelSources,
    this.onChangeSubSource,
    this.toastString,
    this.isLandscape = false,
    this.isBuffering = false,
    this.isPlaying = false,
    this.aspectRatio = 16 / 9,
  }) : super(key: key);

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
          return const SubScribePage(
            isTV: true,
          );
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
        debugPrint('按了右键');
        break;
      case LogicalKeyboardKey.arrowLeft:
        debugPrint('按了左键');
        break;
      case LogicalKeyboardKey.arrowUp:
        debugPrint('按了上键');
        _videoNode.unfocus();
        await widget.changeChannelSources?.call();
        Future.delayed(const Duration(seconds: 1), () => _videoNode.requestFocus());
        break;
      case LogicalKeyboardKey.arrowDown:
        debugPrint('按了下键');
        widget.controller?.pause();
        _videoNode.unfocus();
        final isChangeSource = await _openAddSource();
        if (isChangeSource == true) {
          widget.onChangeSubSource?.call();
        } else {
          widget.controller?.play();
        }
        Future.delayed(const Duration(seconds: 1), () => _videoNode.requestFocus());
        break;
      case LogicalKeyboardKey.select:
        debugPrint('按了确认键');
        if (!widget.isPlaying) {
          widget.controller?.play();
          return;
        }
        if (!Scaffold.of(context).isDrawerOpen) {
          Scaffold.of(context).openDrawer();
        }
        break;
      case LogicalKeyboardKey.goBack:
        debugPrint('按了返回键');
        break;
      case LogicalKeyboardKey.contextMenu:
        debugPrint('按了菜单键');
        if (!Scaffold.of(context).isDrawerOpen) {
          Scaffold.of(context).openDrawer();
        }
        break;
      case LogicalKeyboardKey.audioVolumeUp:
        debugPrint('按了音量加键');
        break;
      case LogicalKeyboardKey.audioVolumeDown:
        debugPrint('按了音量减键');
        break;
      case LogicalKeyboardKey.f5:
        debugPrint('按了语音键');
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
      backgroundColor: Colors.greenAccent,
      drawer: ChannelDrawerPage(
        videoMap: widget.videoMap,
        channelName: widget.channelName,
        groupName: widget.groupName,
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
          child: Container(
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
                            child: const Icon(Icons.play_circle_outline,
                                color: Colors.white, size: 50)),
                      if (widget.isBuffering) const SpinKitSpinningLines(color: Colors.white)
                    ],
                  )
                : VideoHoldBg(toastString: widget.toastString),
          ),
        );
      }),
    );
  }
}
