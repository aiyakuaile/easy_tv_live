import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import '../entity/subScribe_model.dart';
import '../provider/theme_provider.dart';
import 'font_util.dart';
import 'm3u_util.dart';

class DeviceSyncUtil {
  DeviceSyncUtil._();

  static applyAllSettings(BuildContext context, Map<String, dynamic> syncMap) async {
    final textScaleFactor = syncMap['textScaleFactor'];
    final fontFamily = syncMap['fontFamily'];
    final fontUrl = syncMap['fontUrl'];
    final isBingBg = syncMap['isBingBg'];
    final videoSource = syncMap['videoSource'];

    if (textScaleFactor != null) {
      context.read<ThemeProvider>().setTextScale(textScaleFactor);
    }

    if (isBingBg != null) {
      context.read<ThemeProvider>().setBingBg(isBingBg);
    }

    if (fontUrl != null || fontFamily != null) {
      final fontRes = fontFamily == 'system' ? true : await FontUtil().loadFont(fontUrl, fontFamily);
      if (fontRes) {
        if (context.mounted) context.read<ThemeProvider>().setFontFamily(fontFamily, fontUrl);
      }
    }

    if (videoSource != null) {
      final source = videoSource as List;
      await M3uUtil.saveLocalData(source.map((e) => SubScribeModel.fromJson(e)).toList());
      await SpUtil.remove('m3u_cache');
    }

    EasyLoading.showSuccess('同步成功');
  }

  static Future<Map<String, dynamic>> syncAllSettings(BuildContext context) async {
    final textScaleFactor = context.read<ThemeProvider>().textScaleFactor;
    final fontFamily = context.read<ThemeProvider>().fontFamily;
    final fontUrl = context.read<ThemeProvider>().fontUrl;
    final isBingBg = context.read<ThemeProvider>().isBingBg;
    final source = await _getVideoSource();
    final msg = {'textScaleFactor': textScaleFactor, 'fontFamily': fontFamily, 'fontUrl': fontUrl, 'isBingBg': isBingBg, 'videoSource': source};
    return msg;
  }

  static Future<Map<String, dynamic>> syncVideoList() async {
    final source = await _getVideoSource();
    final msg = {'videoSource': source};
    return msg;
  }

  static Future<Map<String, dynamic>> syncFont(BuildContext context) async {
    final textScaleFactor = context.read<ThemeProvider>().textScaleFactor;
    final fontFamily = context.read<ThemeProvider>().fontFamily;
    final fontUrl = context.read<ThemeProvider>().fontUrl;
    final msg = {
      'textScaleFactor': textScaleFactor,
      'fontFamily': fontFamily,
      'fontUrl': fontUrl,
    };
    return msg;
  }

  static Future<Map<String, dynamic>> syncPrettify(BuildContext context) async {
    final isBingBg = context.read<ThemeProvider>().isBingBg;
    final msg = {
      'isBingBg': isBingBg,
    };
    return msg;
  }

  static Future<List<Map<String, dynamic>>> _getVideoSource() async {
    final res = await M3uUtil.getLocalData();
    return res.map((e) => e.toJson()).toList();
  }
}
