import 'dart:convert' as convert;

import 'package:easy_tv_live/entity/sub_scribe_model.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/env_util.dart';

class RemoteModel {
  RemoteModel({
    this.dtaId,
    this.channels,
    this.dataValueProxy,
    this.timeoutSwitchLine,
    this.leftRightSelect,
    this.fontScale,
    this.appFontFamily,
    this.appFontUrl,
    this.bingBg,
    this.autoUpdate,
    this.lightVersionCheck,
  });

  RemoteModel.fromJson(dynamic json) {
    dtaId = json['dtaId'];
    List<String> channel = json['channels'] != null ? json['channels'].cast<String>() : [];
    if (channel!.isNotEmpty) {
      channels = channel!
          .map(
            (ca) => SubScribeModel(
              time: DateUtil.formatDateMs(dtaId!, format: DateFormats.full),
              link: ca,
              selected: false,
              local: false,
            ),
          )
          .toList();
      channels![0].selected = true;
    }
    dataValueProxy = int.tryParse(json['dataValueProxy']) ?? 1;
    timeoutSwitchLine = int.tryParse(json['timeoutSwitchLine']) ?? 15;
    leftRightSelect = json['leftRightSelect'];
    fontScale = double.tryParse(json['fontScale']) ?? 1.0;
    final appFont = convert.json.decode(json['appFontFamily']);
    appFontFamily = appFont['font_key'];
    if (appFont['font_key'] != 'system') {
      final fontLink = '${EnvUtil.proxyList[dataValueProxy!]}https://raw.githubusercontent.com/aiyakuaile/easy_tv_font/main';
      final fontUrl = '$fontLink/fonts/${appFontFamily!}.${appFont['font_type']}';
      appFontUrl = fontUrl;
    } else {
      appFontUrl = '';
    }
    bingBg = json['bingBg'];
    autoUpdate = json['autoUpdate'];
    lightVersionCheck = json['lightVersionCheck'];
  }
  int? dtaId;
  List<SubScribeModel>? channels;
  int? dataValueProxy;
  int? timeoutSwitchLine;
  bool? leftRightSelect;
  double? fontScale;
  String? appFontFamily;
  String? appFontUrl;
  bool? bingBg;
  bool? autoUpdate;
  bool? lightVersionCheck;
}
