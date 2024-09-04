import 'dart:math';

import 'package:easy_tv_live/provider/theme_provider.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/epg_util.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'entity/playlist_model.dart';
import 'util/env_util.dart';

class ChannelDrawerPage extends StatefulWidget {
  final PlaylistModel? videoMap;
  final PlayModel? playModel;
  final bool isLandscape;
  final Function(PlayModel? newModel)? onTapChannel;

  const ChannelDrawerPage({super.key, this.videoMap, this.playModel, this.onTapChannel, this.isLandscape = true});

  @override
  State<ChannelDrawerPage> createState() => _ChannelDrawerPageState();
}

class _ChannelDrawerPageState extends State<ChannelDrawerPage> {
  final _scrollController = ScrollController();
  final _scrollChannelController = ScrollController();
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

  _loadEPGMsg() async {
    if (!_isShowEPG) return;
    setState(() {
      _epgData = null;
      _selEPGIndex = 0;
    });
    final res = await EpgUtil.getEpg(widget.playModel);
    if (res == null || res!.epgData == null || res!.epgData!.isEmpty) return;
    _epgData = res.epgData!;
    final epgRangeTime = DateUtil.formatDate(DateTime.now(), format: 'HH:mm');
    final selectTimeData = _epgData!.where((element) => element.start!.compareTo(epgRangeTime) < 0).last.start;
    final selIndex = _epgData!.indexWhere((element) => element.start == selectTimeData);
    _selEPGIndex = selIndex;
    setState(() {});
  }

  @override
  void initState() {
    LogUtil.v('ChannelDrawerPage:isTV:::$isTV');
    _keys = widget.videoMap?.playList?.keys.toList() ?? <String>[];
    _values = widget.videoMap?.playList?.values.toList().cast<Map>() ?? <Map>[];
    _groupIndex = _keys.indexWhere((element) => element == (widget.playModel?.group ?? ''));
    if (_groupIndex != -1) {
      _channelIndex = _values[_groupIndex].keys.toList().indexWhere((element) => element == widget.playModel!.title);
    }
    if (_groupIndex == -1) {
      _groupIndex = 0;
    }
    if (_channelIndex == -1) {
      _channelIndex = 0;
    }
    LogUtil.v('ChannelDrawerPage:initState:::groupIndex=$_groupIndex==channelIndex=$_channelIndex');
    Future.delayed(Duration.zero, () {
      if (_viewPortHeight == null) {
        final RenderBox? renderBox = _viewPortKey.currentContext?.findRenderObject() as RenderBox?;
        final double height = renderBox?.size?.height ?? 0;
        _viewPortHeight = height * 0.5;
        LogUtil.v('ChannelDrawerPage:initState:_viewPortHeight::height=$height');
      }
      if (_groupIndex != 0) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final shouldOffset = _groupIndex * _itemHeight - _viewPortHeight! + _itemHeight * 0.5;
        if (shouldOffset < maxScrollExtent) {
          _scrollController.jumpTo(max(0.0, shouldOffset));
        } else {
          _scrollController.jumpTo(maxScrollExtent);
        }
      }
      if (_channelIndex != 0) {
        final maxScrollExtent = _scrollChannelController.position.maxScrollExtent;
        final shouldOffset = _channelIndex * _itemHeight - _viewPortHeight! + _itemHeight * 0.5;
        if (shouldOffset < maxScrollExtent) {
          _scrollChannelController.jumpTo(max(0.0, shouldOffset));
        } else {
          _scrollChannelController.jumpTo(maxScrollExtent);
        }
      }
    });
    _loadEPGMsg();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollChannelController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChannelDrawerPage oldWidget) {
    if (widget.playModel != oldWidget.playModel) {
      setState(() {
        _keys = widget.videoMap?.playList?.keys.toList() ?? <String>[];
        _values = widget.videoMap?.playList?.values.toList().cast<Map>() ?? <Map>[];
        int groupIndex = _keys.indexWhere((element) => element == widget.playModel?.group);
        int channelIndex = _channelIndex;
        if (groupIndex != -1) {
          channelIndex = _values[groupIndex].keys.toList().indexWhere((element) => element == widget.playModel?.title);
        }
        if (groupIndex == -1) {
          groupIndex = 0;
        }
        if (channelIndex == -1) {
          channelIndex = 0;
        }
        _groupIndex = groupIndex;
        _channelIndex = channelIndex;
        if (_groupIndex == 0 && _scrollController.positions.isNotEmpty) {
          Future.delayed(Duration.zero, () => _scrollController.jumpTo(0));
        }
        if (_channelIndex == 0 && _scrollChannelController.positions.isNotEmpty) {
          Future.delayed(Duration.zero, () => _scrollChannelController.jumpTo(0));
        }
      });
      _loadEPGMsg();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _buildOpenDrawer();
  }

  Widget _buildOpenDrawer() {
    double drawWidth = max(MediaQuery.of(context).size.width * 0.5 + MediaQuery.of(context).padding.left, 300);
    final screenWidth = MediaQuery.of(context).size.width;
    _isShowEPG = (drawWidth + 200) < screenWidth;
    if (_isShowEPG && _epgData != null && _epgData!.isNotEmpty) {
      drawWidth += 200;
    }
    return Container(
      key: _viewPortKey,
      padding: EdgeInsets.only(left: MediaQuery.of(context).padding.left),
      width: widget.isLandscape ? drawWidth : screenWidth,
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.transparent])),
      child: Row(children: [
        SizedBox(
          width: 100 * context.read<ThemeProvider>().textScaleFactor,
          child: ListView.builder(
              cacheExtent: _itemHeight,
              padding: const EdgeInsets.only(bottom: 100.0),
              controller: _scrollController,
              itemBuilder: (context, index) {
                final title = _keys[index];
                return Builder(builder: (context) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      overlayColor: isTV ? WidgetStateProperty.all(Colors.greenAccent.withOpacity(0.2)) : null,
                      onTap: () {
                        if (_groupIndex != index) {
                          setState(() {
                            _groupIndex = index;
                            final name = _values[_groupIndex].keys.toList()[0].toString();
                            final newModel = widget.videoMap!.playList![_keys[_groupIndex]]![name];
                            widget.onTapChannel?.call(newModel);
                          });
                          _scrollChannelController.jumpTo(0);
                          Scrollable.ensureVisible(context, alignment: 0.5, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        } else {
                          Scaffold.of(context).closeDrawer();
                        }
                      },
                      onFocusChange: (focus) async {
                        if (focus) {
                          Scrollable.ensureVisible(context, alignment: 0.5, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        }
                      },
                      splashColor: Colors.white.withOpacity(0.3),
                      child: Ink(
                        width: double.infinity,
                        height: _itemHeight,
                        decoration: BoxDecoration(
                          gradient: _groupIndex == index ? LinearGradient(colors: [Colors.red.withOpacity(0.6), Colors.red.withOpacity(0.3)]) : null,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: TextStyle(color: _groupIndex == index ? Colors.red : Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                });
              },
              itemCount: _keys.length),
        ),
        VerticalDivider(width: 0.1, color: Colors.white.withOpacity(0.1)),
        if (_values.isNotEmpty && _values[_groupIndex].isNotEmpty)
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 100.0),
                cacheExtent: _itemHeight,
                controller: _scrollChannelController,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  final name = _values[_groupIndex].keys.toList()[index].toString();
                  return Builder(builder: (context) {
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        overlayColor: isTV ? WidgetStateProperty.all(Colors.greenAccent.withOpacity(0.2)) : null,
                        canRequestFocus: isTV,
                        onTap: () async {
                          if (widget.playModel?.title == name) {
                            Scaffold.of(context).closeDrawer();
                            return;
                          }
                          final newModel = widget.videoMap!.playList![_keys[_groupIndex]]![name];
                          widget.onTapChannel?.call(newModel);
                          Scrollable.ensureVisible(context, alignment: 0.5, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        },
                        onFocusChange: (focus) async {
                          if (focus) {
                            Scrollable.ensureVisible(context, alignment: 0.5, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                          }
                        },
                        splashColor: Colors.white.withOpacity(0.3),
                        child: Ink(
                          width: double.infinity,
                          height: _itemHeight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            gradient:
                                widget.playModel?.title == name ? LinearGradient(colors: [Colors.red.withOpacity(0.3), Colors.transparent]) : null,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  style: TextStyle(color: widget.playModel?.title == name ? Colors.red : Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              if (widget.playModel?.title == name) SpinKitWave(size: 20, color: Colors.red.withOpacity(0.8))
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                },
                itemCount: _values[_groupIndex].length),
          ),
        if (_isShowEPG) VerticalDivider(width: 0.1, color: Colors.white.withOpacity(0.1)),
        if (_isShowEPG && _epgData != null && _epgData!.isNotEmpty)
          SizedBox(
            width: 200,
            child: Column(
              children: [
                Container(
                  height: 44,
                  alignment: Alignment.center,
                  child: const Text(
                    '节目单',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                VerticalDivider(width: 0.1, color: Colors.white.withOpacity(0.1)),
                Flexible(
                  child: ScrollablePositionedList.builder(
                      initialScrollIndex: _selEPGIndex,
                      itemBuilder: (BuildContext context, int index) {
                        final data = _epgData![index];
                        final isSelect = index == _selEPGIndex;
                        return Container(
                          constraints: const BoxConstraints(
                            minHeight: 40,
                          ),
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${data.start}-${data.end}\n${data.title}',
                            style: TextStyle(
                                fontWeight: isSelect ? FontWeight.bold : FontWeight.normal, color: isSelect ? Colors.redAccent : Colors.white),
                          ),
                        );
                      },
                      itemCount: _epgData!.length),
                ),
              ],
            ),
          )
      ]),
    );
  }
}
