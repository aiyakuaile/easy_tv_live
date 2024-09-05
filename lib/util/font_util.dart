import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'http_util.dart';
import 'log_util.dart';

class FontUtil {
  FontUtil._();

  static final FontUtil _instance = FontUtil._();

  factory FontUtil() {
    return _instance;
  }

  Future<String> getFontPath() async {
    final path = (await getApplicationSupportDirectory()).path;
    return '$path/fonts';
  }

  Future<Uint8List?> downloadFont(String url, {bool overwrite = false, ValueChanged<double>? progressCallback}) async {
    final uri = Uri.parse(url);
    final filename = uri.pathSegments.last;
    final dir = await getFontPath();
    final fontPath = '$dir/$filename';
    final file = File(fontPath);
    if (await file.exists() && !overwrite) {
      LogUtil.v('****** font $filename already exists *****${await file.length()}');
      return file.readAsBytes();
    }
    final bytes = await downloadBytes(url, filename, fontPath, progressCallback: progressCallback);
    return bytes;
  }

  Future<Uint8List?> downloadBytes(String url, String filename, String savePath, {ValueChanged<double>? progressCallback}) async {
    final code = await HttpUtil().downloadFile(url, savePath, progressCallback: progressCallback);
    if (code == 200) {
      return File(savePath).readAsBytes();
    } else {
      return null;
    }
  }

  Future<void> deleteFont(String url) async {
    final uri = Uri.parse(url);
    final filename = uri.pathSegments.last;
    final dir = (await getApplicationSupportDirectory()).path;
    final file = File('$dir/$filename');
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<bool> loadFont(String url, String fontFamily, {ValueChanged<double>? progressCallback}) async {
    final fontByte = await downloadFont(url, progressCallback: progressCallback);
    if (fontByte == null) return false;
    try {
      await loadFontFromList(fontByte, fontFamily: fontFamily);
      return true;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      return false;
    }
  }
}
