import 'dart:io';

import 'package:sp_util/sp_util.dart';

class EnvUtil {
  static bool? _isMobile;
  static const List<String> proxyList = ['', 'https://easytv.suntengfei.top/', 'http://ghp.keleyaa.com/'];

  static bool isTV() {
    return const bool.fromEnvironment('isTV');
  }

  static int get _proxyIndex => SpUtil.getInt('dataValueProxy', defValue: 1)!;

  static bool get isMobile {
    if (_isMobile != null) return _isMobile!;
    _isMobile = Platform.isAndroid || Platform.isIOS;
    return _isMobile!;
  }

  static String sourceDownloadHost() {
    return '${proxyList[_proxyIndex]}https://github.com/aiyakuaile/easy_tv_live/releases/download';
  }

  static String sourceReleaseHost() {
    return 'https://github.com/aiyakuaile/easy_tv_live/releases';
  }

  static String sourceHomeHost() {
    return 'https://github.com/aiyakuaile/easy_tv_live';
  }

  static String videoDefaultChannelHost() {
    return '${proxyList[_proxyIndex]}https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/temp';
  }

  static String checkVersionHost() {
    return '${proxyList[_proxyIndex]}https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/versions.json';
  }

  static String fontLink() {
    return '${proxyList[_proxyIndex]}https://raw.githubusercontent.com/aiyakuaile/easy_tv_font/main';
  }

  static String rewardLink() {
    return '${proxyList[_proxyIndex]}https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/reward.txt';
  }
}
