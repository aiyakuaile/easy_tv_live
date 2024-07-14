import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

double lastTimeOffset = 0.0;
double lastTimeChannelOffset = 0.0;

class ChannelDrawerPage extends StatefulWidget {
  final Map<String, dynamic>? videoMap;
  final String? channelName;
  final String? groupName;
  final bool isLandscape;
  final Function(String group, String channel)? onTapChannel;

  const ChannelDrawerPage(
      {Key? key,
      this.videoMap,
      this.groupName,
      this.channelName,
      this.onTapChannel,
      this.isLandscape = true})
      : super(key: key);

  @override
  _ChannelDrawerPageState createState() => _ChannelDrawerPageState();
}

class _ChannelDrawerPageState extends State<ChannelDrawerPage> {
  late ScrollController _scrollController;
  late ScrollController _scrollChannelController;

  late List<String> _keys;
  late List<Map> _values;
  late int _groupIndex = -1;
  late int _channelIndex = -1;

  @override
  void initState() {
    debugPrint('_groupIndex===$_groupIndex===$_channelIndex');
    _keys = widget.videoMap?.keys.toList() ?? <String>[];
    _values = widget.videoMap?.values.toList().cast<Map>() ?? <Map>[];
    _groupIndex = _keys.indexWhere((element) => element == widget.groupName);
    if (_groupIndex != -1) {
      _channelIndex =
          _values[_groupIndex].keys.toList().indexWhere((element) => element == widget.channelName);
    }
    _scrollController = ScrollController(initialScrollOffset: lastTimeOffset)
      ..addListener(() {
        lastTimeOffset = _scrollController.offset;
      });
    _scrollChannelController = ScrollController(initialScrollOffset: lastTimeChannelOffset)
      ..addListener(() {
        lastTimeChannelOffset = _scrollChannelController.offset;
      });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChannelDrawerPage oldWidget) {
    setState(() {
      _keys = widget.videoMap?.keys.toList() ?? <String>[];
      _values = widget.videoMap?.values.toList().cast<Map>() ?? <Map>[];
      _groupIndex = _keys.indexWhere((element) => element == widget.groupName);
      if (_groupIndex != -1) {
        _channelIndex = _values[_groupIndex]
            .keys
            .toList()
            .indexWhere((element) => element == widget.channelName);
      }
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildEndDrawer();
  }

  Widget _buildEndDrawer() {
    return Container(
      padding: EdgeInsets.only(left: MediaQuery.of(context).padding.left),
      width: widget.isLandscape
          ? MediaQuery.of(context).size.height - 64 + MediaQuery.of(context).padding.left
          : MediaQuery.of(context).size.width,
      decoration:
          const BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.transparent])),
      child: Row(children: [
        SizedBox(
          width: 80,
          child: ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                final title = _keys[index];
                return Builder(builder: (context) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (_groupIndex != index) {
                          setState(() {
                            _groupIndex = index;
                          });
                          _scrollChannelController.jumpTo(0);
                          Scrollable.ensureVisible(context,
                              alignment: 0.5, duration: const Duration(milliseconds: 500));
                        }
                      },
                      onFocusChange: (focus) async {
                        if (focus) {
                          if (widget.groupName == title) return;
                            final name = _values[index].keys.toList()[0].toString();
                            widget.onTapChannel?.call(_keys[index].toString(), name);

                          _scrollChannelController.animateTo(0,
                              duration: const Duration(milliseconds: 200), curve: Curves.linear);
                          setState(() {
                            _groupIndex = index;
                          });
                          await Scrollable.ensureVisible(context,
                              alignment: 0.5, duration: const Duration(milliseconds: 200));
                        }
                      },
                      splashColor: Colors.white.withOpacity(0.3),
                      child: Ink(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: _groupIndex == index
                              ? LinearGradient(colors: [
                                  Colors.red.withOpacity(0.6),
                                  Colors.red.withOpacity(0.3)
                                ])
                              : null,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: TextStyle(
                                color: _groupIndex == index ? Colors.red : Colors.white,
                                fontWeight: FontWeight.bold),
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
        if (_groupIndex != -1)
          Expanded(
            flex: 2,
            child: ListView.builder(
                controller: _scrollChannelController,
                itemBuilder: (context, index) {
                  final name = _values[_groupIndex].keys.toList()[index].toString();
                  return Builder(builder: (context) {
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        autofocus: widget.channelName == name,
                        onTap: () async {
                          if (widget.channelName == name) {
                            Scaffold.of(context).closeDrawer();
                            return;
                          }
                          widget.onTapChannel?.call(_keys[_groupIndex].toString(), name);
                          Scrollable.ensureVisible(context,
                              alignment: 0.5, duration: const Duration(milliseconds: 500));
                        },
                        onFocusChange: (focus) async {
                          if (focus && widget.channelName != name) {
                            widget.onTapChannel?.call(_keys[_groupIndex].toString(), name);
                            Scrollable.ensureVisible(context,
                                alignment: 0.5, duration: const Duration(milliseconds: 500));
                          }
                        },
                        splashColor: Colors.white.withOpacity(0.3),
                        child: Ink(
                          width: double.infinity,
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            gradient: widget.channelName == name
                                ? LinearGradient(
                                    colors: [Colors.red.withOpacity(0.3), Colors.transparent])
                                : null,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                      color: widget.channelName == name ? Colors.red : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              if (widget.channelName == name)
                                SpinKitWave(size: 20, color: Colors.red.withOpacity(0.8))
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                },
                itemCount: _values[_groupIndex].length),
          ),
      ]),
    );
  }
}
