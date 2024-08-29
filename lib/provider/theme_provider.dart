import 'package:flutter/foundation.dart';
import 'package:sp_util/sp_util.dart';

import '../util/font_util.dart';

class ThemeProvider extends ChangeNotifier {
  String _fontFamily = 'system';
  double _textScaleFactor = 1.0;
  String _fontUrl = '';
  bool _isBingBg = false;

  String get fontFamily => _fontFamily;
  double get textScaleFactor => _textScaleFactor;
  String get fontUrl => _fontUrl;
  bool get isBingBg => _isBingBg;

  ThemeProvider() {
    _fontFamily = SpUtil.getString('appFontFamily', defValue: 'system')!;
    _fontUrl = SpUtil.getString('appFontUrl', defValue: '')!;
    _textScaleFactor = SpUtil.getDouble('fontScale', defValue: 1.0)!;
    _isBingBg = SpUtil.getBool('bingBg', defValue: false)!;
    if (_fontFamily != 'system') {
      FontUtil().loadFont(_fontUrl, _fontFamily);
    }
  }

  void setFontFamily(String fontFamilyName, [String fontFullUrl = '']) {
    SpUtil.putString('appFontFamily', fontFamilyName);
    SpUtil.putString('appFontUrl', fontFullUrl);
    _fontFamily = fontFamilyName;
    _fontUrl = fontFullUrl;
    notifyListeners();
  }

  void setTextScale(double textScaleFactor) {
    SpUtil.putDouble('fontScale', textScaleFactor);
    _textScaleFactor = textScaleFactor;
    notifyListeners();
  }

  void setBingBg(bool isOpen) {
    SpUtil.putBool('bingBg', isOpen);
    _isBingBg = isOpen;
    notifyListeners();
  }
}
