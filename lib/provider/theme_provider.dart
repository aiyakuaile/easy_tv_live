import 'package:flutter/foundation.dart';
import 'package:sp_util/sp_util.dart';

import '../util/font_util.dart';

class ThemeProvider extends ChangeNotifier {
  String _fontFamily = 'system';
  double _textScaleFactor = 1.0;
  String _fontUrl = '';
  bool _isBingBg = false;
  bool _useLightVersionCheck = true;
  bool _useDataProxy = true;
  bool _useAutoUpdate = false;
  bool _useLeftRightSelect = false;

  bool get useAutoUpdate => _useAutoUpdate;
  bool get useLightVersionCheck => _useLightVersionCheck;
  bool get useDataProxy => _useDataProxy;
  String get fontFamily => _fontFamily;
  double get textScaleFactor => _textScaleFactor;
  String get fontUrl => _fontUrl;
  bool get isBingBg => _isBingBg;
  bool get useLeftRightSelect => _useLeftRightSelect;

  ThemeProvider() {
    _useAutoUpdate = SpUtil.getBool('autoUpdate', defValue: false)!;
    _useLightVersionCheck = SpUtil.getBool('lightVersionCheck', defValue: true)!;
    _useDataProxy = SpUtil.getBool('dataProxy', defValue: true)!;
    _fontFamily = SpUtil.getString('appFontFamily', defValue: 'system')!;
    _fontUrl = SpUtil.getString('appFontUrl', defValue: '')!;
    _textScaleFactor = SpUtil.getDouble('fontScale', defValue: 1.0)!;
    _isBingBg = SpUtil.getBool('bingBg', defValue: false)!;
    _useLeftRightSelect = SpUtil.getBool('leftRightSelect', defValue: false)!;
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

  void setLightVersionCheck(bool isOpen) {
    SpUtil.putBool('lightVersionCheck', isOpen);
    _useLightVersionCheck = isOpen;
    notifyListeners();
  }

  void setDataProxy(bool isOpen) {
    SpUtil.putBool('dataProxy', isOpen);
    _useDataProxy = isOpen;
    notifyListeners();
  }

  void setAutoUpdate(bool isOpen) {
    SpUtil.putBool('autoUpdate', isOpen);
    _useAutoUpdate = isOpen;
    notifyListeners();
  }

  void setLeftRightSelect(bool isOpen) {
    SpUtil.putBool('leftRightSelect', isOpen);
    _useLeftRightSelect = isOpen;
    notifyListeners();
  }
}
