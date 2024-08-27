import 'dart:io';
import 'dart:ui';

class EnvUtil {
  static bool? _isMobile;

  static bool isTV() {
    return const bool.fromEnvironment('isTV');
  }

  static bool get isMobile {
    if (_isMobile != null) return _isMobile!;
    _isMobile = Platform.isAndroid || Platform.isIOS;
    return _isMobile!;
  }

  static bool isChinese() {
    final systemLocale = PlatformDispatcher.instance.locale;
    bool isChinese = systemLocale.languageCode == 'zh';
    return isChinese;
  }

  static String sourceDownloadHost() {
    if (isChinese()) {
      return 'https://gitee.com/AMuMuSir/easy_tv_live/releases/download';
    } else {
      return 'https://github.com/aiyakuaile/easy_tv_live/releases/download';
    }
  }

  static String sourceReleaseHost() {
    if (isChinese()) {
      return 'https://gitee.com/AMuMuSir/easy_tv_live/releases';
    } else {
      return 'https://github.com/aiyakuaile/easy_tv_live/releases';
    }
  }

  static String sourceHomeHost() {
    if (isChinese()) {
      return 'https://gitee.com/AMuMuSir/easy_tv_live';
    } else {
      return 'https://github.com/aiyakuaile/easy_tv_live';
    }
  }

  static String videoDefaultChannelHost() {
    if (isChinese()) {
      return 'https://gitee.com/AMuMuSir/easy_tv_live/raw/main/temp';
    } else {
      return 'https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/temp';
    }
  }

  static String checkVersionHost() {
    if (isChinese()) {
      return 'https://gitee.com/api/v5/repos/AMuMuSir/easy_tv_live/releases/latest';
    } else {
      return 'https://api.github.com/repos/aiyakuaile/easy_tv_live/releases/latest';
    }
  }

  static String fontLink() {
    if (isChinese()) {
      return 'https://gitee.com/AMuMuSir/easy_tv_font/raw/main';
    } else {
      return 'https://raw.githubusercontent.com/aiyakuaile/easy_tv_font/main';
    }
  }
}
