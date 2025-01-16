import 'dart:async';

import 'package:easy_tv_live/entity/play_channel_list_model.dart';
import 'package:easy_tv_live/tv/tv_channel_drawer_page.dart';
import 'package:easy_tv_live/util/latency_checker_util.dart';
import 'package:easy_tv_live/util/m3u_util.dart';
import 'package:easy_tv_live/widget/date_position_widget.dart';
import 'package:easy_tv_live/widget/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sp_util/sp_util.dart';
import 'package:video_player/video_player.dart';

import '../util/log_util.dart';
import '../widget/video_hold_bg.dart';

class TvPage extends StatefulWidget {
  final PlayChannelListModel? channelListModel;
  final Function(Channel? newChannel)? onTapChannel;

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
    this.channelListModel,
    this.onTapChannel,
    this.controller,
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
  Timer? _digitTimer;

  bool _drawerIsOpen = false;

  final ValueNotifier<String> _digitSelValue = ValueNotifier('');

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
        if (_digitSelValue.value.isNotEmpty) return;
        _videoNode.unfocus();
        await widget.changeChannelSources?.call();
        Future.delayed(const Duration(seconds: 1), () => _videoNode.requestFocus());
        break;
      case LogicalKeyboardKey.arrowDown:
        LogUtil.v('按了下键');
        if (_digitSelValue.value.isNotEmpty) return;
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
        if (_digitSelValue.value.isNotEmpty) return;
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
          LatencyCheckerUtil.latencies.clear();
          Scaffold.of(context).openDrawer();
        }
        break;
      case LogicalKeyboardKey.goBack:
        LogUtil.v('按了返回键');
        break;
      case LogicalKeyboardKey.contextMenu:
        if (_digitSelValue.value.isNotEmpty) return;
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
      case LogicalKeyboardKey.digit0:
        _handleDigitInput(context, 0);
        break;
      case LogicalKeyboardKey.digit1:
        _handleDigitInput(context, 1);
        break;
      case LogicalKeyboardKey.digit2:
        _handleDigitInput(context, 2);
        break;
      case LogicalKeyboardKey.digit3:
        _handleDigitInput(context, 3);
        break;
      case LogicalKeyboardKey.digit4:
        _handleDigitInput(context, 4);
        break;
      case LogicalKeyboardKey.digit5:
        _handleDigitInput(context, 5);
        break;
      case LogicalKeyboardKey.digit6:
        _handleDigitInput(context, 6);
        break;
      case LogicalKeyboardKey.digit7:
        _handleDigitInput(context, 7);
        break;
      case LogicalKeyboardKey.digit8:
        _handleDigitInput(context, 8);
        break;
      case LogicalKeyboardKey.digit9:
        _handleDigitInput(context, 9);
        break;
    }
  }

  _handleDigitInput(BuildContext context, int digitNum) {
    if (widget.channelListModel == null) return;
    _digitTimer?.cancel();
    _digitTimer = null;
    _digitSelValue.value += digitNum.toString();
    _digitTimer = Timer(const Duration(milliseconds: 2000), () {
      _digitTimer?.cancel();
      _digitTimer = null;
      final channel = M3uUtil.serialNumMap[_digitSelValue.value];
      if (channel == null) {
        EasyLoading.showToast('无节目数据，请重新选台');
      } else {
        EasyLoading.showToast('开始播放：${channel.title}');
        widget.channelListModel!.playChannelIndex = channel.channelIndex;
        widget.channelListModel!.playGroupIndex = channel.groupIndex;
        widget.onTapChannel?.call(channel);
      }
      _digitSelValue.value = '';
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _digitTimer?.cancel();
    _digitTimer = null;
    _videoNode.dispose();
    _digitSelValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: TVChannelDrawerPage(
        channelListModel: widget.channelListModel,
        onTapChannel: widget.onTapChannel,
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
                      ValueListenableBuilder(
                          valueListenable: _digitSelValue,
                          builder: (BuildContext context, String value, Widget? child) {
                            if (value.isNotEmpty) {
                              return Positioned(
                                  top: 30,
                                  left: 30,
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.white, fontSize: 50),
                                      )));
                            }
                            return SizedBox.shrink();
                          })
                    ],
                  ),
                ),
        );
      }),
    );
  }
}
