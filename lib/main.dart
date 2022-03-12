import 'dart:convert';
import 'dart:io';

import 'package:easy_tv_live/channel_drawer_page.dart';
import 'package:easy_tv_live/mobile_video_widget.dart';
import 'package:easy_tv_live/table_video_widget.dart';
import 'package:easy_tv_live/video_hold_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// 导入http请求库
import 'package:http/http.dart' as http;
// 导入video_player库
import 'package:video_player/video_player.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  runApp(const MyApp());
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV Checker',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Kaiti'
      ),
      home: const HomePage(),
      builder: EasyLoading.init(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final httpClient = http.Client();

  String toastString = '正在加载';

  Map<String, dynamic>? _videoMap;

  String _group = '';
  String _channel = '';
  int _sourceIndex = 0;

  VideoPlayerController? _playerController;

  bool isBuffering = false;

 int _subSourceIndex = 0;

 final List<String> _subSourceList = [
   'https://raw.githubusercontent.com/zbefine/iptv/main/iptv.m3u',
   'https://iptv-org.github.io/iptv/index.nsfw.m3u'
 ];
  

  _playVideo() async {
    setState(() {
      toastString = '正在播放：$_channel';
    });
    final url = _videoMap![_group][_channel][_sourceIndex].toString();
    if (_playerController != null) {
      await _playerController?.dispose();
      _playerController = null;
      setState(() {});
    }
    _playerController =
        VideoPlayerController.network(url, formatHint: VideoFormat.hls)
          ..initialize().then((value) {
            setState(() {
              toastString = '正在加载';
            });
            _playerController!.play();
          }).catchError((e) {
            setState(() {
              toastString = '无法播放，请重试或切换其他信源重试';
            });
          });
        _playerController!.addListener(() {
          if(isBuffering != _playerController!.value.isBuffering){
            setState(() {
              isBuffering = _playerController!.value.isBuffering;
            });
          }
        });
  }

  _onTapChannel(String group, String channel) {
    _group = group;
    _channel = channel;
    _sourceIndex = 0;
    _playVideo();
  }

  @override
  void initState() {
    super.initState();
    _parseData();
  }

  @override
  dispose() {
    Wakelock.disable();
    _playerController?.dispose();
    super.dispose();
  }

  _parseData() async {
    final res = await _fetchData();
    final resMap = await _parseM3u(res);
    // debugPrint('resMap======: ${jsonEncode(resMap)}');
    _videoMap = resMap;
    _group = _videoMap!.keys.first.toString();
    _channel = Map.from(_videoMap![_group]).keys.first;
    _sourceIndex = 0;
    _playVideo();
  }

  // 从assets异步读取cn.m3u文件
  Future<String> _fetchData() async {
    final response = await httpClient.get(
      Uri.parse(_subSourceList[_subSourceIndex]),
    );
    if (response.statusCode == 200) {
      try{
        return utf8.decode(response.body.codeUnits);
      }catch(e){
        return response.body;
      }
    } else {
      debugPrint('使用默认直播源====');
      return rootBundle.loadString('assets/resources/default.m3u');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      child: OrientationLayoutBuilder(
        portrait: (context) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          return MobileVideoWidget(
              toastString: toastString,
              controller: _playerController,
              changeChannelSources: _changeChannelSources,
              isLandscape: false,
              isBuffering: isBuffering,
              subSourceIndex: _subSourceIndex,
              onChangeSubSource:(int index){
                _subSourceIndex = index;
                setState(() {});
                _parseData();
              },
              drawChild: ChannelDrawerPage(
                videoMap: _videoMap,
                channelName: _channel,
                groupName: _group,
                onTapChannel: _onTapChannel,
                isLandscape:false
              ),
          );
        },
        landscape: (context) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
          return WillPopScope(
            onWillPop: ()async{
              SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
              return false;
            },
            child: Scaffold(
              drawer: ChannelDrawerPage(
                  videoMap: _videoMap,
                  channelName: _channel,
                  groupName: _group,
                  onTapChannel: _onTapChannel,
                  isLandscape:true
              ),
              drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.3,
              body: TableVideoWidget(
                  toastString: toastString,
                  controller: _playerController,
                  isBuffering: isBuffering,
                  changeChannelSources: _changeChannelSources,
                  isLandscape: true
              ),
            ),
          );
        },
      ),
      // body: ScreenTypeLayout.builder(
      //   mobile: _buildTabletAndDeskTop,
      //   tablet: _buildTabletAndDeskTop,
      //   desktop: _buildTabletAndDeskTop,
      //   watch: (BuildContext context) => Container(color: Colors.purple),
      // ),
    );
  }

  _changeChannelSources() async {
    List sources = _videoMap![_group][_channel];
    final selectedIndex = await showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        backgroundColor: Colors.black87,
        builder: (BuildContext context) {
          return Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
            color: Colors.transparent,
            child: Wrap(
                spacing: 15,
                runSpacing: 20,
                children: List.generate(sources.length, (index) {
                  return OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: _sourceIndex != index
                              ? Colors.black45
                              : Colors.red.withOpacity(0.1)),
                      child: Text(
                        '信源${index + 1}',
                        style: TextStyle(
                            color: _sourceIndex == index
                                ? Colors.red
                                : Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context, index);
                      });
                })),
          );
        });
    if (selectedIndex != null) {
      _sourceIndex = selectedIndex;
      debugPrint('切换信号源:====$_sourceIndex');
      _playVideo();
    }
  }

  // 解析m3u文件为Map
  Future<Map<String, dynamic>> _parseM3u(String m3u) async {
    final lines = m3u.split('\n');
    final result = <String, dynamic>{};
    for (int i = 0; i < lines.length - 1; i++) {
      final line = lines[i];
      if (line.startsWith('#EXTINF:')) {
        final lineList = line.split(',');
        debugPrint('lineList==${lineList.first}');
        List<String> params = lineList.first.replaceAll('"', '').split(' ');
        final groupStr = params.firstWhere((element) => element.startsWith('group-title='),orElse: ()=>'');
        if(groupStr.isNotEmpty){
          final groupTitle = groupStr.split('=').last;
          final channelName = lineList.last;
          Map group = result[groupTitle] ?? {};
          List groupList = group[channelName] ?? [];
          final lineNext = lines[i + 1];
          if (lineNext.startsWith('http')) {
            groupList.add(lineNext);
            group[channelName] = groupList;
            result[groupTitle] = group;
            i+=1;
          }else if(lines[i + 2].startsWith('http')){
            groupList.add(lines[i + 2].toString());
            group[channelName] = groupList;
            result[groupTitle] = group;
            i+=2;
          }
        }
      }
    }
    return result;
  }

  // 检测m3u8连接是否可以正常播放
  Future<bool> checkM3U8(String url) async {
    try {
      final uri = Uri.parse(url);
      var response = await httpClient.get(uri);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        // 判断是否包含#EXTM3U
        if (responseBody.contains('#EXTM3U')) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('check error=====>$e');
      return false;
    }
  }
}
