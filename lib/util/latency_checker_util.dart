import 'dart:async';

import 'package:easy_tv_live/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LatencyCheckerUtil {
  static const int goodThreshold = 100; // 毫秒
  static const int averageThreshold = 300; // 毫秒
  static const int poorThreshold = 500; // 毫秒
  static const Duration timeoutDuration = Duration(seconds: 5); // 设置超时时间为5秒
  static Map<String, Color> latencies = {};
  static Future<Color> checkLatencies(String url) async {
    if (latencies.containsKey(url)) {
      return latencies[url] ?? Colors.transparent;
    }
    final client = http.Client();
    try {
      final stopwatch = Stopwatch()..start();
      final response = await client.head(
        Uri.parse(url),
        headers: {'Connection': 'close'},
      ).timeout(timeoutDuration);
      LogUtil.v('url:::$url::\n:::${response.reasonPhrase}');
      stopwatch.stop();
      final duration = stopwatch.elapsed.inMilliseconds;
      latencies[url] = classifyLatency(duration);
    } on TimeoutException catch (_) {
      latencies[url] = Colors.blueGrey;
    } catch (e) {
      latencies[url] = Colors.blueGrey;
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
    } else if (duration < poorThreshold) {
      return Colors.orangeAccent;
    } else {
      return Colors.blueGrey;
    }
  }
}
