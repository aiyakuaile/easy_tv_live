import 'package:easy_tv_live/entity/remote_model.dart';
import 'package:easy_tv_live/util/m3u_util.dart';
import 'package:flutter/foundation.dart';
import 'package:sp_util/sp_util.dart';

import '../util/font_util.dart';

class ThemeProvider extends ChangeNotifier {
  String _fontFamily = 'system';
  double _textScaleFactor = 1.0;
  String _fontUrl = '';
  bool _isBingBg = false;
  bool _useLightVersionCheck = true;
  int _useDataValueProxy = 1;
  bool _useAutoUpdate = false;
  bool _useLeftRightSelect = false;
  int _prePlaySerialNum = 1;
  int _timeoutSwitchLine = 15;
  String? _remoteControlLink = '';

  bool get useAutoUpdate => _useAutoUpdate;
  bool get useLightVersionCheck => _useLightVersionCheck;
  int get useDataValueProxy => _useDataValueProxy;
  String get fontFamily => _fontFamily;
  double get textScaleFactor => _textScaleFactor;
  String get fontUrl => _fontUrl;
  bool get isBingBg => _isBingBg;
  bool get useLeftRightSelect => _useLeftRightSelect;
  int get prePlaySerialNum => _prePlaySerialNum;
  int get timeoutSwitchLine => _timeoutSwitchLine;
  bool get isOpenRemoteControl => _remoteControlLink != null && _remoteControlLink!.isNotEmpty;
  String? get remoteControlLink => _remoteControlLink;

  ThemeProvider() {
    _useAutoUpdate = SpUtil.getBool('autoUpdate', defValue: false)!;
    _useLightVersionCheck = SpUtil.getBool('lightVersionCheck', defValue: true)!;
    _useDataValueProxy = SpUtil.getInt('dataValueProxy', defValue: 1)!;
    _fontFamily = SpUtil.getString('appFontFamily', defValue: 'system')!;
    _fontUrl = SpUtil.getString('appFontUrl', defValue: '')!;
    _textScaleFactor = SpUtil.getDouble('fontScale', defValue: 1.0)!;
    _isBingBg = SpUtil.getBool('bingBg', defValue: false)!;
    _useLeftRightSelect = SpUtil.getBool('leftRightSelect', defValue: true)!;
    _prePlaySerialNum = SpUtil.getInt('prePlaySerialNum', defValue: 1)!;
    _timeoutSwitchLine = SpUtil.getInt('timeoutSwitchLine', defValue: 15)!;
    _remoteControlLink = SpUtil.getString('remoteControlLink', defValue: '');
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

  void setDataValueProxy(int val) {
    SpUtil.putInt('dataValueProxy', val);
    _useDataValueProxy = val;
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

  void setPrePlaySerialNum(int serialNum) {
    SpUtil.putInt('prePlaySerialNum', serialNum);
    _prePlaySerialNum = serialNum;
    notifyListeners();
  }

  void setTimeoutSwitchLine(int val) {
    SpUtil.putInt('timeoutSwitchLine', val);
    _timeoutSwitchLine = val;
    notifyListeners();
  }

  void setRemoteControlLink(String? link) {
    SpUtil.putString('remoteControlLink', link ?? '');
    _remoteControlLink = link;
    notifyListeners();
  }

  Future<void> setRemoteData(RemoteModel model) async {
    SpUtil.putInt('remoteDtaId', model.dtaId!);
    await M3uUtil.saveLocalData(model.channels ?? []);
    SpUtil.putInt('dataValueProxy', model.dataValueProxy!);
    _useDataValueProxy = model.dataValueProxy!;
    SpUtil.putInt('timeoutSwitchLine', model.timeoutSwitchLine!);
    _timeoutSwitchLine = model.timeoutSwitchLine!;
    SpUtil.putBool('leftRightSelect', model.leftRightSelect!);
    _useLeftRightSelect = model.leftRightSelect!;
    SpUtil.putDouble('fontScale', model.fontScale!);
    _textScaleFactor = model.fontScale!;
    SpUtil.putBool('bingBg', model.bingBg!);
    _isBingBg = model.bingBg!;
    SpUtil.putBool('autoUpdate', model.autoUpdate!);
    _useAutoUpdate = model.autoUpdate!;
    SpUtil.putBool('lightVersionCheck', model.lightVersionCheck!);
    _useLightVersionCheck = model.lightVersionCheck!;
    SpUtil.putString('appFontFamily', model.appFontFamily!);
    SpUtil.putString('appFontUrl', model.appFontUrl!);
    _fontFamily = model.appFontFamily!;
    _fontUrl = model.appFontUrl!;
    if (_fontFamily != 'system') {
      await FontUtil().loadFont(_fontUrl, _fontFamily);
    }
    notifyListeners();
  }
}
