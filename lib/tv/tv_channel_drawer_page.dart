import 'dart:math';

import 'package:easy_tv_live/entity/play_channel_list_model.dart';
import 'package:easy_tv_live/provider/theme_provider.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/epg_util.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../util/env_util.dart';

enum FocusColumn { group, channel, epg }

class TVChannelDrawerPage extends StatefulWidget {
  final PlayChannelListModel? channelListModel;
  final Function(Channel? newChannel)? onTapChannel;

  const TVChannelDrawerPage({super.key, this.channelListModel, this.onTapChannel});

  @override
  State<TVChannelDrawerPage> createState() => _TVChannelDrawerPageState();
}

class _TVChannelDrawerPageState extends State<TVChannelDrawerPage> {
  final _scrollController = ScrollController();
  final _scrollChannelController = ScrollController();
  final _epgScrollController = ItemScrollController();
  List<EpgData>? _epgData;
  int _selEPGIndex = 0;

  final _viewPortKey = GlobalKey();
  double? _viewPortHeight;

  int _groupIndex = 0;
  int _channelIndex = 0;

  final _itemHeight = 50.0;
  bool _isShowEPG = true;
  final isTV = true;

  final _focusNode = FocusNode();
  FocusColumn _currentFocusColumn = FocusColumn.channel;

  _loadEPGMsg() async {
    if (!_isShowEPG || widget.channelListModel == null) return;
    setState(() {
      _epgData = null;
      _selEPGIndex = 0;
    });
    Future.delayed(const Duration(milliseconds: 300), () async {
      final playGroupIndex = widget.channelListModel!.playGroupIndex!;
      final playChannelIndex = widget.channelListModel!.playChannelIndex!;
      final channel = widget.channelListModel!.playList![playGroupIndex].channel![playChannelIndex];
      final res = await EpgUtil.getEpg(channel);
      if (res == null || res.epgData == null || res.epgData!.isEmpty) return;
      _epgData = res.epgData!;
      final epgRangeTime = DateUtil.formatDate(DateTime.now(), format: 'HH:mm');
      final selectTimeData = _epgData!.where((element) => element.start!.compareTo(epgRangeTime) < 0).last.start;
      final selIndex = _epgData!.indexWhere((element) => element.start == selectTimeData);
      _selEPGIndex = selIndex;
      setState(() {});
    });
  }

  @override
  void initState() {
    LogUtil.v('ChannelDrawerPage:isTV:::$isTV');
    final playGroupIndex = widget.channelListModel!.playGroupIndex!;
    final playChannelIndex = widget.channelListModel!.playChannelIndex!;
    _groupIndex = playGroupIndex;
    _channelIndex = playChannelIndex;
    Future.delayed(Duration.zero, () {
      if (_viewPortHeight == null) {
        final RenderBox? renderBox = _viewPortKey.currentContext?.findRenderObject() as RenderBox?;
        final double height = renderBox?.size.height ?? 0;
        _viewPortHeight = height * 0.5;
        LogUtil.v('ChannelDrawerPage:initState:_viewPortHeight::height=$height');
      }

      if (playGroupIndex != 0) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final shouldOffset = playGroupIndex * _itemHeight - _viewPortHeight! + _itemHeight * 0.5;
        if (shouldOffset < maxScrollExtent) {
          _scrollController.jumpTo(max(0.0, shouldOffset));
        } else {
          _scrollController.jumpTo(maxScrollExtent);
        }
      }
      if (playChannelIndex != 0) {
        final maxScrollExtent = _scrollChannelController.position.maxScrollExtent;
        final shouldOffset = playChannelIndex * _itemHeight - _viewPortHeight! + _itemHeight * 0.5;
        if (shouldOffset < maxScrollExtent) {
          _scrollChannelController.jumpTo(max(0.0, shouldOffset));
        } else {
          _scrollChannelController.jumpTo(maxScrollExtent);
        }
      }
    });
    _loadEPGMsg();
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollChannelController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    if (event.logicalKey == LogicalKeyboardKey.escape ||
        event.logicalKey == LogicalKeyboardKey.browserBack ||
        event.logicalKey == LogicalKeyboardKey.goBack) {
      Navigator.of(context).pop();
      return;
    }

    switch (_currentFocusColumn) {
      case FocusColumn.group:
        _handleGroupKeyEvent(event);
        break;
      case FocusColumn.channel:
        _handleChannelKeyEvent(event);
        break;
      case FocusColumn.epg:
        _handleEpgKeyEvent(event);
        break;
    }
  }

  void _ensureGroupItemVisible() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final shouldOffset = _groupIndex * _itemHeight - _viewPortHeight! + _itemHeight * 0.5;
        if (shouldOffset < maxScrollExtent) {
          _scrollController.animateTo(max(0.0, shouldOffset), duration: const Duration(milliseconds: 300), curve: Curves.linear);
        } else {
          _scrollController.animateTo(maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        }
      }
    });
  }

  void _ensureChannelItemVisible() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_scrollChannelController.hasClients) {
        final maxScrollExtent = _scrollChannelController.position.maxScrollExtent;
        final shouldOffset = _channelIndex * _itemHeight - _viewPortHeight! + _itemHeight * 0.5;
        if (shouldOffset < maxScrollExtent) {
          _scrollChannelController.animateTo(max(0.0, shouldOffset), duration: const Duration(milliseconds: 300), curve: Curves.linear);
        } else {
          _scrollChannelController.animateTo(maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        }
      }
    });
  }

  void _handleGroupKeyEvent(KeyDownEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _groupIndex -= 1;
      if (_groupIndex < 0) {
        _groupIndex = widget.channelListModel!.playList!.length - 1;
      }
      setState(() {});
      _ensureGroupItemVisible();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _groupIndex++;
      if (_groupIndex > widget.channelListModel!.playList!.length - 1) {
        _groupIndex = 0;
      }
      setState(() {});
      _ensureGroupItemVisible();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      setState(() {
        _currentFocusColumn = FocusColumn.channel;
        _groupIndex = widget.channelListModel?.playGroupIndex ?? 0;
        _channelIndex = widget.channelListModel?.playChannelIndex ?? 0;
      });
      _ensureGroupItemVisible();
      _ensureChannelItemVisible();
    } else if (event.logicalKey == LogicalKeyboardKey.select || event.logicalKey == LogicalKeyboardKey.enter) {
      if (_groupIndex == widget.channelListModel?.playGroupIndex) {
        Navigator.of(context).pop();
        return;
      }
      setState(() {
        widget.channelListModel!.playGroupIndex = _groupIndex;
        widget.channelListModel!.playChannelIndex = 0;
        _channelIndex = 0;
        _currentFocusColumn = FocusColumn.channel;
        widget.onTapChannel?.call(widget.channelListModel!.playList![_groupIndex].channel![_channelIndex]);
        if (_scrollChannelController.hasClients) {
          _scrollChannelController.jumpTo(0);
        }
        _loadEPGMsg();
      });
    }
  }

  void _handleChannelKeyEvent(KeyDownEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      if (_channelIndex > 0) {
        setState(() {
          _channelIndex--;
        });
      } else {
        setState(() {
          _channelIndex = widget.channelListModel!.playList![_groupIndex].channel!.length - 1;
        });
      }
      _ensureChannelItemVisible();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      if (_channelIndex < widget.channelListModel!.playList![_groupIndex].channel!.length - 1) {
        setState(() {
          _channelIndex++;
        });
      } else {
        setState(() {
          _channelIndex = 0;
        });
      }
      _ensureChannelItemVisible();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      setState(() {
        _currentFocusColumn = FocusColumn.group;
        _channelIndex = widget.channelListModel?.playChannelIndex ?? 0;
      });
      _ensureChannelItemVisible();
      _ensureGroupItemVisible();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      setState(() {
        if (_isShowEPG && _epgData != null && _epgData!.isNotEmpty) {
          _channelIndex = widget.channelListModel?.playChannelIndex ?? 0;
          _currentFocusColumn = FocusColumn.epg;
          final epgRangeTime = DateUtil.formatDate(DateTime.now(), format: 'HH:mm');
          final currentEpgIndex = _epgData!.indexWhere(
            (element) => element.start!.compareTo(epgRangeTime) <= 0 && element.end!.compareTo(epgRangeTime) > 0,
          );
          if (currentEpgIndex != -1) {
            _selEPGIndex = currentEpgIndex;
            _epgScrollController.scrollTo(index: _selEPGIndex, alignment: 0.3, duration: const Duration(milliseconds: 150), curve: Curves.linear);
          }
          _ensureChannelItemVisible();
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.select || event.logicalKey == LogicalKeyboardKey.enter) {
      if (widget.channelListModel?.playChannelIndex == _channelIndex) {
        Navigator.of(context).pop();
        return;
      }
      widget.channelListModel!.playChannelIndex = _channelIndex;
      final newModel = widget.channelListModel!.playList![_groupIndex].channel![_channelIndex];
      widget.onTapChannel?.call(newModel);
      _loadEPGMsg();
    }
  }

  void _handleEpgKeyEvent(KeyDownEvent event) {
    if (!_isShowEPG || _epgData == null || _epgData!.isEmpty) return;

    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      if (_selEPGIndex > 0) {
        setState(() {
          _selEPGIndex--;
        });
        Future.delayed(Duration(milliseconds: 300), () {
          _epgScrollController.scrollTo(index: _selEPGIndex, alignment: 0.3, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        });
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      if (_selEPGIndex < _epgData!.length - 1) {
        setState(() {
          _selEPGIndex++;
        });
        Future.delayed(Duration(milliseconds: 300), () {
          _epgScrollController.scrollTo(index: _selEPGIndex, alignment: 0.3, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        });
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      final epgRangeTime = DateUtil.formatDate(DateTime.now(), format: 'HH:mm');
      final currentEpgIndex = _epgData!.indexWhere(
        (element) => element.start!.compareTo(epgRangeTime) <= 0 && element.end!.compareTo(epgRangeTime) > 0,
      );
      if (currentEpgIndex != -1) {
        setState(() {
          _selEPGIndex = currentEpgIndex;
        });
        _epgScrollController.scrollTo(index: currentEpgIndex, alignment: 0.3, duration: const Duration(milliseconds: 300), curve: Curves.linear);
      }
      setState(() {
        _currentFocusColumn = FocusColumn.channel;
      });
      _ensureChannelItemVisible();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (_, event) {
        _handleKeyEvent(event);
        return KeyEventResult.handled;
      },
      child: _buildOpenDrawer(),
    );
  }

  Widget _buildOpenDrawer() {
    double drawWidth = max(MediaQuery.of(context).size.width * 0.4 + MediaQuery.of(context).padding.left, 300);
    final screenWidth = MediaQuery.of(context).size.width;
    double egpWidth = 260.0;
    _isShowEPG = (drawWidth + egpWidth) < screenWidth;
    if (_isShowEPG && _epgData != null && _epgData!.isNotEmpty) {
      drawWidth += egpWidth;
    }
    bool isShowEpgWidget = _isShowEPG && _epgData != null && _epgData!.isNotEmpty;
    return Container(
      key: _viewPortKey,
      padding: EdgeInsets.only(left: MediaQuery.of(context).padding.left),
      width: drawWidth,
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.transparent])),
      child: Row(
        children: [
          SizedBox(
            width: 100 * context.read<ThemeProvider>().textScaleFactor,
            child: ListView.builder(
              cacheExtent: _itemHeight,
              padding: const EdgeInsets.only(bottom: 100.0),
              controller: _scrollController,
              itemBuilder: (context, index) {
                final title = widget.channelListModel!.playList![index].group!;
                return _buildGroupItem(index, title);
              },
              itemCount: widget.channelListModel?.playList?.length ?? 0,
            ),
          ),
          VerticalDivider(width: 0.1, color: Colors.white.withValues(alpha: 0.1)),
          if ((widget.channelListModel?.playList?.length ?? 0) > 0 &&
              (widget.channelListModel!.playList![widget.channelListModel!.playGroupIndex!].channel?.length ?? 0) > 0)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 100.0),
                cacheExtent: _itemHeight,
                controller: _scrollChannelController,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  final channel = widget.channelListModel!.playList![widget.channelListModel!.playGroupIndex!].channel![index];
                  final name = channel.title!;
                  final serialNum = channel.serialNum!;
                  return _buildChannelItem(index, '$serialNum $name');
                },
                itemCount: widget.channelListModel!.playList![widget.channelListModel!.playGroupIndex!].channel!.length,
              ),
            ),
          if (isShowEpgWidget)
            SizedBox(
              width: egpWidth,
              child: Material(
                color: Colors.black.withValues(alpha: 0.1),
                child: Column(
                  children: [
                    Container(
                      height: 44,
                      alignment: Alignment.center,
                      child: const Text('节目单', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                    ),
                    VerticalDivider(width: 0.1, color: Colors.white.withValues(alpha: 0.1)),
                    Flexible(
                      child: ScrollablePositionedList.builder(
                        initialScrollIndex: _selEPGIndex,
                        itemScrollController: _epgScrollController,
                        initialAlignment: 0.3,
                        physics: const ClampingScrollPhysics(),
                        padding: isTV && EnvUtil.isMobile ? EdgeInsets.only(bottom: MediaQuery.of(context).size.height) : null,
                        itemBuilder: (BuildContext context, int index) {
                          final data = _epgData![index];
                          return _buildEpgItem(data, index);
                        },
                        itemCount: _epgData!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGroupItem(int index, String title) {
    final bool isSelected = widget.channelListModel!.playGroupIndex == index;
    final bool isFocused = _currentFocusColumn == FocusColumn.group && index == _groupIndex;

    return Container(
      width: double.infinity,
      height: _itemHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            if (isFocused) ...[
              Colors.greenAccent.withValues(alpha: 0.3),
              Colors.greenAccent.withValues(alpha: 0.1),
            ] else if (isSelected) ...[
              Colors.red.withValues(alpha: 0.6),
              Colors.red.withValues(alpha: 0.3),
            ] else ...[
              Colors.transparent,
              Colors.transparent,
            ],
          ],
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: isFocused ? Colors.white : (isSelected ? Colors.red : Colors.white), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildChannelItem(int index, String name) {
    final bool isSelected = widget.channelListModel!.playChannelIndex == index;
    final bool isFocused = _currentFocusColumn == FocusColumn.channel && index == _channelIndex;

    return Container(
      width: double.infinity,
      height: _itemHeight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            if (isFocused) ...[
              Colors.greenAccent.withValues(alpha: 0.3),
              Colors.greenAccent.withValues(alpha: 0.1),
            ] else if (isSelected) ...[
              Colors.red.withValues(alpha: 0.3),
              Colors.transparent,
            ] else ...[
              Colors.transparent,
              Colors.transparent,
            ],
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(color: isFocused ? Colors.white : (isSelected ? Colors.red : Colors.white), fontWeight: FontWeight.bold),
            ),
          ),
          if (isSelected) SpinKitWave(size: 20, color: Colors.red.withValues(alpha: 0.8)),
        ],
      ),
    );
  }

  Widget _buildEpgItem(EpgData data, int index) {
    final bool isCurrentPlaying = _isCurrentPlayingEpg(data);
    final bool isFocused = _currentFocusColumn == FocusColumn.epg && index == _selEPGIndex;

    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            if (isFocused) ...[
              Colors.greenAccent.withValues(alpha: 0.3),
              Colors.greenAccent.withValues(alpha: 0.1),
            ] else ...[
              Colors.transparent,
              Colors.transparent,
            ],
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${data.start}-${data.end}',
            style: TextStyle(
              fontWeight: isCurrentPlaying ? FontWeight.bold : FontWeight.normal,
              color: isCurrentPlaying ? Colors.red : Colors.white,
              fontSize: isCurrentPlaying ? 17 : 15,
            ),
          ),
          Text(
            '${data.title}',
            style: TextStyle(
              fontWeight: isCurrentPlaying ? FontWeight.bold : FontWeight.normal,
              color: isCurrentPlaying ? Colors.red : Colors.white,
              fontSize: isCurrentPlaying ? 17 : 15,
            ),
          ),
        ],
      ),
    );
  }

  bool _isCurrentPlayingEpg(EpgData data) {
    final now = DateUtil.formatDate(DateTime.now(), format: 'HH:mm');
    return data.start!.compareTo(now) <= 0 && data.end!.compareTo(now) > 0;
  }
}
