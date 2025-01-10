import 'dart:async';

import 'package:easy_tv_live/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LatencyCheckerUtil {
  static const int goodThreshold = 1000;
  static const int averageThreshold = 2000;
  static const int poorThreshold = 3000;
  static const Duration timeoutDuration = Duration(seconds: 5); // 设置超时时间为5秒
  static Map<String, Color> latencies = {};
  static Future<Color> checkLatencies(String url) async {
    if (latencies.containsKey(url)) {
      return latencies[url] ?? Colors.transparent;
    }
    final client = http.Client();
    try {
      final stopwatch = Stopwatch()..start();
      await client.get(
        Uri.parse(url),
        headers: {'Connection': 'close', 'Range': 'bytes=0-99'},
      ).timeout(timeoutDuration);
      stopwatch.stop();
      final duration = stopwatch.elapsed.inMilliseconds;
      LogUtil.v('url:::成功:::$url::\n:::>>>>$duration');
      latencies[url] = classifyLatency(duration);
    } on TimeoutException catch (e) {
      LogUtil.v('url:::超时:::$url::\n:::$e');
      latencies[url] = Colors.blueGrey;
    } catch (e) {
      LogUtil.v('url:::报错:::$url::\n:::$e');
      latencies[url] = Colors.redAccent;
    } finally {
      client.close();
    }
    return latencies[url] ?? Colors.transparent;
  }

  static Color classifyLatency(int duration) {
    if (duration < goodThreshold) {
      return Colors.greenAccent;
    } else if (duration < averageThreshold) {
      return Colors.blueAccent;
    } else {
      return Colors.orangeAccent;
    }
  }
}
