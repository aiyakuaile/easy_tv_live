import 'package:flutter/foundation.dart';
import 'package:sp_util/sp_util.dart';

class ThemeProvider extends ChangeNotifier {
  String _fontFamily = 'system';
  double _textScaleFactor = 1.0;

  String get fontFamily => _fontFamily;
  double get textScaleFactor => _textScaleFactor;

  ThemeProvider() {
    _fontFamily = SpUtil.getString('fontFamily', defValue: 'system')!;
    _textScaleFactor = SpUtil.getDouble('fontScale', defValue: 1.0)!;
  }

  void setFontFamily(String fontFamily) {
    SpUtil.putString('fontFamily', fontFamily);
    _fontFamily = fontFamily;
    notifyListeners();
  }

  void setTextScale(double textScaleFactor) {
    SpUtil.putDouble('fontScale', textScaleFactor);
    _textScaleFactor = textScaleFactor;
    notifyListeners();
  }
}
