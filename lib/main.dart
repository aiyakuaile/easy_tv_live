import 'dart:convert';
import 'package:flutter/material.dart';
// 导入http请求库
import 'package:http/http.dart' as http;
// 导入video_player库
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
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

  Map<String, dynamic>? videoMap;

  @override
  void initState() {
    super.initState();
    _parseData();
  }

  _parseData() async {
    final res = await _fetchData();
    final resMap = await _parseM3u(res);
    // debugPrint('resMap======: ${json.encode(resMap)}');
    setState(() {
      videoMap = resMap;
    });
  }

  // 从assets异步读取cn.m3u文件
  Future<String> _fetchData() async {
    final response = await httpClient.get(
      Uri.parse('https://raw.githubusercontent.com/zbefine/iptv/main/iptv.m3u'),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // 解析m3u文件为Map
  Future<Map<String, dynamic>> _parseM3u(String m3u) async {
    final lines = m3u.split('\n');
    final result = <String, dynamic>{};
    for (int i = 0; i < lines.length - 1; i++) {
      final line = lines[i];
      if (line.startsWith('#EXTINF:')) {
        final lineList = line.split(',');
        final groupTitle = lineList.first
            .replaceFirst('#EXTINF:-1 group-title=', '')
            .replaceAll("\"", '');
        final channelName = lineList.last;
        Map group = result[groupTitle] ?? {};
        List groupList = group[channelName] ?? [];
        final lineNext = lines[i + 1];
        if (lineNext.startsWith('http') && lineNext.contains('.m3u8')) {
          groupList.add(lineNext);
          group[channelName] = groupList;
          result[groupTitle] = group;
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
