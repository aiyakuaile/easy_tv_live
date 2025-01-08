import 'dart:math';

import 'package:easy_tv_live/provider/theme_provider.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/epg_util.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../entity/playlist_model.dart';
import '../util/env_util.dart';

enum FocusColumn { group, channel, epg }

class TVChannelDrawerPage extends StatefulWidget {
  final PlaylistModel? videoMap;
  final PlayModel? playModel;
  final bool isLandscape;
  final Function(PlayModel? newModel)? onTapChannel;

  const TVChannelDrawerPage(
      {super.key,
      this.videoMap,
      this.playModel,
      this.onTapChannel,
      this.isLandscape = true});

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

  late List<String> _keys;
  late List<Map> _values;
  late int _groupIndex = 0;
  late int _channelIndex = 0;
  final _itemHeight = 50.0;
  bool _isShowEPG = true;
  final isTV = EnvUtil.isTV();

  final _focusNode = FocusNode();
  FocusColumn _currentFocusColumn = FocusColumn.group;

  late int _selectedGroupIndex = 0;

  _loadEPGMsg() async {
    if (!_isShowEPG) return;
    setState(() {
      _epgData = null;
      _selEPGIndex = 0;
    });
    final res = await EpgUtil.getEpg(widget.playModel);
    if (res == null || res.epgData == null || res.epgData!.isEmpty) return;
    _epgData = res.epgData!;
    final epgRangeTime = DateUtil.formatDate(DateTime.now(), format: 'HH:mm');
    final selectTimeData = _epgData!
        .where((element) => element.start!.compareTo(epgRangeTime) < 0)
        .last
        .start;
    final selIndex =
        _epgData!.indexWhere((element) => element.start == selectTimeData);
    _selEPGIndex = selIndex;
    setState(() {});
  }

  @override
  void initState() {
    LogUtil.v('ChannelDrawerPage:isTV:::$isTV');
    _keys = widget.videoMap?.playList?.keys.toList() ?? <String>[];
    _values = widget.videoMap?.playList?.values.toList().cast<Map>() ?? <Map>[];
    _groupIndex = _keys
        .indexWhere((element) => element == (widget.playModel?.group ?? ''));
    if (_groupIndex != -1) {
      _channelIndex = _values[_groupIndex]
          .keys
          .toList()
          .indexWhere((element) => element == widget.playModel!.title);
    }
    if (_groupIndex == -1) {
      _groupIndex = 0;
    }
    if (_channelIndex == -1) {
      _channelIndex = 0;
    }
    LogUtil.v(
        'ChannelDrawerPage:initState:::groupIndex=$_groupIndex==channelIndex=$_channelIndex');
    Future.delayed(Duration.zero, () {
      if (_viewPortHeight == null) {
        final RenderBox? renderBox =
            _viewPortKey.currentContext?.findRenderObject() as RenderBox?;
        final double height = renderBox?.size.height ?? 0;
        _viewPortHeight = height * 0.5;
        LogUtil.v(
            'ChannelDrawerPage:initState:_viewPortHeight::height=$height');
      }
      if (_groupIndex != 0) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final shouldOffset =
            _groupIndex * _itemHeight - _viewPortHeight! + _itemHeight * 0.5;
        if (shouldOffset < maxScrollExtent) {
          _scrollController.jumpTo(max(0.0, shouldOffset));
        } else {
          _scrollController.jumpTo(maxScrollExtent);
        }
      }
      if (_channelIndex != 0) {
        final maxScrollExtent =
            _scrollChannelController.position.maxScrollExtent;
        final shouldOffset =
            _channelIndex * _itemHeight - _viewPortHeight! + _itemHeight * 0.5;
        if (shouldOffset < maxScrollExtent) {
          _scrollChannelController.jumpTo(max(0.0, shouldOffset));
        } else {
          _scrollChannelController.jumpTo(maxScrollExtent);
        }
      }
    });
    _loadEPGMsg();
    _focusNode.requestFocus();
    _selectedGroupIndex = _groupIndex;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollChannelController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TVChannelDrawerPage oldWidget) {
    if (widget.playModel != oldWidget.playModel) {
      setState(() {
        _keys = widget.videoMap?.playList?.keys.toList() ?? <String>[];
        _values =
            widget.videoMap?.playList?.values.toList().cast<Map>() ?? <Map>[];

        if (widget.playModel != null) {
          int newGroupIndex =
              _keys.indexWhere((element) => element == widget.playModel?.group);
          int newChannelIndex = -1;

          if (newGroupIndex != -1) {
            newChannelIndex = _values[newGroupIndex]
                .keys
                .toList()
                .indexWhere((element) => element == widget.playModel?.title);
          }

          _groupIndex = newGroupIndex != -1 ? newGroupIndex : 0;
          _selectedGroupIndex = _groupIndex;
          _channelIndex = newChannelIndex != -1 ? newChannelIndex : 0;
        }
      });
      _loadEPGMsg();
    }
    super.didUpdateWidget(oldWidget);
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
        final shouldOffset =
            _groupIndex * _itemHeight - _viewPortHeight! + _itemHeight * 0.5;
        if (shouldOffset < maxScrollExtent) {
          _scrollController.animateTo(
            max(0.0, shouldOffset),
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        } else {
          _scrollController.animateTo(
            maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  void _ensureChannelItemVisible() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_scrollChannelController.hasClients) {
        final maxScrollExtent =
            _scrollChannelController.position.maxScrollExtent;
        final shouldOffset =
            _channelIndex * _itemHeight - _viewPortHeight! + _itemHeight * 0.5;
        if (shouldOffset < maxScrollExtent) {
          _scrollChannelController.animateTo(
            max(0.0, shouldOffset),
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        } else {
          _scrollChannelController.animateTo(
            maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  void _handleGroupKeyEvent(KeyDownEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      if (_groupIndex > 0) {
        setState(() {
          _groupIndex--;
        });
        _ensureGroupItemVisible();
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      if (_groupIndex < _keys.length - 1) {
        setState(() {
          _groupIndex++;
        });
        _ensureGroupItemVisible();
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      if (widget.playModel != null) {
        final playingGroupIndex =
            _keys.indexWhere((element) => element == widget.playModel?.group);
        if (playingGroupIndex != -1) {
          setState(() {
            _groupIndex = playingGroupIndex;
          });
          _ensureGroupItemVisible();
        }
      }

      setState(() {
        _currentFocusColumn = FocusColumn.channel;
        if (widget.playModel != null &&
            widget.playModel?.group == _keys[_selectedGroupIndex]) {
          _channelIndex = _values[_selectedGroupIndex]
              .keys
              .toList()
              .indexWhere((element) => element == widget.playModel?.title);
          if (_channelIndex == -1) {
            _channelIndex = 0;
          }
        }
      });
      _ensureChannelItemVisible();
    } else if (event.logicalKey == LogicalKeyboardKey.select ||
        event.logicalKey == LogicalKeyboardKey.enter) {
      if (widget.playModel?.group == _keys[_groupIndex]) {
        Navigator.of(context).pop();
        return;
      }

      setState(() {
        _selectedGroupIndex = _groupIndex;
        _channelIndex = 0;
        _currentFocusColumn = FocusColumn.channel;

        final name = _values[_selectedGroupIndex].keys.toList()[0].toString();
        final newModel =
            widget.videoMap!.playList![_keys[_selectedGroupIndex]]![name];
        widget.onTapChannel?.call(newModel);

        if (_scrollChannelController.hasClients) {
          _scrollChannelController.jumpTo(0);
        }
      });
    }
  }

  void _handleChannelKeyEvent(KeyDownEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      if (_channelIndex > 0) {
        setState(() {
          _channelIndex--;
        });
        _ensureChannelItemVisible();
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      if (_channelIndex < _values[_selectedGroupIndex].length - 1) {
        setState(() {
          _channelIndex++;
        });
        _ensureChannelItemVisible();
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      if (widget.playModel != null) {
        final playingChannelIndex = _values[_selectedGroupIndex]
            .keys
            .toList()
            .indexWhere((element) => element == widget.playModel?.title);
        if (playingChannelIndex != -1) {
          setState(() {
            _channelIndex = playingChannelIndex;
          });
          _ensureChannelItemVisible();
        }
      }

      setState(() {
        _currentFocusColumn = FocusColumn.group;
        if (widget.playModel != null) {
          _groupIndex =
              _keys.indexWhere((element) => element == widget.playModel?.group);
          if (_groupIndex == -1) {
            _groupIndex = 0;
          }
        }
      });
      _ensureGroupItemVisible();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      if (widget.playModel != null) {
        final playingChannelIndex = _values[_selectedGroupIndex]
            .keys
            .toList()
            .indexWhere((element) => element == widget.playModel?.title);
        if (playingChannelIndex != -1) {
          setState(() {
            _channelIndex = playingChannelIndex;
          });
          _ensureChannelItemVisible();
        }
      }

      if (_isShowEPG && _epgData != null && _epgData!.isNotEmpty) {
        setState(() {
          _currentFocusColumn = FocusColumn.epg;
          final epgRangeTime =
              DateUtil.formatDate(DateTime.now(), format: 'HH:mm');
          final currentEpgIndex = _epgData!.indexWhere((element) =>
              element.start!.compareTo(epgRangeTime) <= 0 &&
              element.end!.compareTo(epgRangeTime) > 0);
          if (currentEpgIndex != -1) {
            _selEPGIndex = currentEpgIndex;
            _epgScrollController.scrollTo(
              index: _selEPGIndex,
              alignment: 0.3,
              duration: const Duration(milliseconds: 150),
              curve: Curves.linear,
            );
          }
        });
      }
    } else if (event.logicalKey == LogicalKeyboardKey.select ||
        event.logicalKey == LogicalKeyboardKey.enter) {
      final name =
          _values[_selectedGroupIndex].keys.toList()[_channelIndex].toString();

      if (widget.playModel?.title == name) {
        Navigator.of(context).pop();
        return;
      }

      final newModel =
          widget.videoMap!.playList![_keys[_selectedGroupIndex]]![name];
      widget.onTapChannel?.call(newModel);
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
          _epgScrollController.scrollTo(
            index: _selEPGIndex,
            alignment: 0.3,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        });
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      if (_selEPGIndex < _epgData!.length - 1) {
        setState(() {
          _selEPGIndex++;
        });
        Future.delayed(Duration(milliseconds: 300), () {
          _epgScrollController.scrollTo(
            index: _selEPGIndex,
            alignment: 0.3,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        });
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      final epgRangeTime = DateUtil.formatDate(DateTime.now(), format: 'HH:mm');
      final currentEpgIndex = _epgData!.indexWhere((element) =>
          element.start!.compareTo(epgRangeTime) <= 0 &&
          element.end!.compareTo(epgRangeTime) > 0);
      if (currentEpgIndex != -1) {
        setState(() {
          _selEPGIndex = currentEpgIndex;
        });
        _epgScrollController.scrollTo(
          index: currentEpgIndex,
          alignment: 0.3,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      }

      setState(() {
        _currentFocusColumn = FocusColumn.channel;
        if (widget.playModel != null) {
          _channelIndex = _values[_selectedGroupIndex]
              .keys
              .toList()
              .indexWhere((element) => element == widget.playModel?.title);
          if (_channelIndex == -1) {
            _channelIndex = 0;
          }
        }
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
    double drawWidth = max(
        MediaQuery.of(context).size.width * 0.4 +
            MediaQuery.of(context).padding.left,
        300);
    final screenWidth = MediaQuery.of(context).size.width;
    double egpWidth = 260.0;
    _isShowEPG = (drawWidth + egpWidth) < screenWidth;
    if (_isShowEPG && _epgData != null && _epgData!.isNotEmpty) {
      drawWidth += egpWidth;
    }
    bool isShowEpgWidget =
        _isShowEPG && _epgData != null && _epgData!.isNotEmpty;
    return Container(
      key: _viewPortKey,
      padding: EdgeInsets.only(left: MediaQuery.of(context).padding.left),
      width: widget.isLandscape ? drawWidth : screenWidth,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black, Colors.transparent])),
      child: Row(children: [
        SizedBox(
          width: 100 * context.read<ThemeProvider>().textScaleFactor,
          child: ListView.builder(
              cacheExtent: _itemHeight,
              padding: const EdgeInsets.only(bottom: 100.0),
              controller: _scrollController,
              itemBuilder: (context, index) {
                final title = _keys[index];
                return _buildGroupItem(index, title);
              },
              itemCount: _keys.length),
        ),
        VerticalDivider(width: 0.1, color: Colors.white.withValues(alpha: 0.1)),
        if (_values.isNotEmpty && _values[_selectedGroupIndex].isNotEmpty)
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 100.0),
                cacheExtent: _itemHeight,
                controller: _scrollChannelController,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  final name = _values[_selectedGroupIndex]
                      .keys
                      .toList()[index]
                      .toString();
                  return _buildChannelItem(index, name);
                },
                itemCount: _values[_selectedGroupIndex].length),
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
                    child: const Text(
                      '节目单',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  VerticalDivider(
                      width: 0.1, color: Colors.white.withValues(alpha: 0.1)),
                  Flexible(
                    child: ScrollablePositionedList.builder(
                      initialScrollIndex: _selEPGIndex,
                      itemScrollController: _epgScrollController,
                      initialAlignment: 0.3,
                      physics: const ClampingScrollPhysics(),
                      padding: isTV && EnvUtil.isMobile
                          ? EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height)
                          : null,
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
          )
      ]),
    );
  }

  Widget _buildGroupItem(int index, String title) {
    final bool isSelected = widget.playModel?.group == _keys[index];
    final bool isFocused =
        _currentFocusColumn == FocusColumn.group && index == _groupIndex;

    return Container(
      width: double.infinity,
      height: _itemHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          if (isFocused) ...[
            Colors.greenAccent.withOpacity(0.3),
            Colors.greenAccent.withOpacity(0.1)
          ] else if (isSelected) ...[
            Colors.red.withValues(alpha: 0.6),
            Colors.red.withValues(alpha: 0.3)
          ] else ...[
            Colors.transparent,
            Colors.transparent
          ]
        ]),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: isFocused
                  ? Colors.white
                  : (isSelected ? Colors.red : Colors.white),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildChannelItem(int index, String name) {
    final bool isSelected = widget.playModel?.title == name;
    final bool isFocused =
        _currentFocusColumn == FocusColumn.channel && index == _channelIndex;

    return Container(
      width: double.infinity,
      height: _itemHeight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          if (isFocused) ...[
            Colors.greenAccent.withOpacity(0.3),
            Colors.greenAccent.withOpacity(0.1)
          ] else if (isSelected) ...[
            Colors.red.withValues(alpha: 0.3),
            Colors.transparent
          ] else ...[
            Colors.transparent,
            Colors.transparent
          ]
        ]),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                  color: isFocused
                      ? Colors.white
                      : (isSelected ? Colors.red : Colors.white),
                  fontWeight: FontWeight.bold),
            ),
          ),
          if (isSelected)
            SpinKitWave(size: 20, color: Colors.red.withValues(alpha: 0.8))
        ],
      ),
    );
  }

  Widget _buildEpgItem(EpgData data, int index) {
    final bool isCurrentPlaying = _isCurrentPlayingEpg(data);
    final bool isFocused =
        _currentFocusColumn == FocusColumn.epg && index == _selEPGIndex;

    return Container(
      constraints: const BoxConstraints(
        minHeight: 40,
      ),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          if (isFocused) ...[
            Colors.greenAccent.withOpacity(0.3),
            Colors.greenAccent.withOpacity(0.1)
          ] else ...[
            Colors.transparent,
            Colors.transparent
          ]
        ]),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${data.start}-${data.end}',
            style: TextStyle(
              fontWeight:
                  isCurrentPlaying ? FontWeight.bold : FontWeight.normal,
              color: isCurrentPlaying ? Colors.red : Colors.white,
              fontSize: isCurrentPlaying ? 17 : 15,
            ),
          ),
          Text(
            '${data.title}',
            style: TextStyle(
              fontWeight:
                  isCurrentPlaying ? FontWeight.bold : FontWeight.normal,
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
