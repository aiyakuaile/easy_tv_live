import 'dart:io';

import 'package:sp_util/sp_util.dart';

class EnvUtil {
  static bool? _isMobile;
  static const String proxy = 'https://easytv.suntengfei.top/';

  static bool isTV() {
    return const bool.fromEnvironment('isTV');
  }

  static bool get _isUseProxy => SpUtil.getBool('proxy', defValue: true)!;

  static bool get isMobile {
    if (_isMobile != null) return _isMobile!;
    _isMobile = Platform.isAndroid || Platform.isIOS;
    return _isMobile!;
  }

  static String sourceDownloadHost() {
    return '${_isUseProxy ? proxy : ''}https://github.com/aiyakuaile/easy_tv_live/releases/download';
  }

  static String sourceReleaseHost() {
    return 'https://github.com/aiyakuaile/easy_tv_live/releases';
  }

  static String sourceHomeHost() {
    return 'https://github.com/aiyakuaile/easy_tv_live';
  }

  static String videoDefaultChannelHost() {
    return '${_isUseProxy ? proxy : ''}https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/temp';
  }

  static String checkVersionHost() {
    return '${_isUseProxy ? proxy : ''}https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/versions.json';
  }

  static String fontLink() {
    return '${_isUseProxy ? proxy : ''}https://raw.githubusercontent.com/aiyakuaile/easy_tv_font/main';
  }

  static String rewardLink() {
    return '${_isUseProxy ? proxy : ''}https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/reward.txt';
  }
}
