import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_tv_live/entity/play_channel_list_model.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/http_util.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:gzip/gzip.dart';
import 'package:xml/xml.dart';

/// channel_name : "CCTV1"
/// date : ""
/// epg_data : []
class EpgUtil {
  EpgUtil._();

  static final _EPGMap = <String, EpgModel>{};
  static Iterable<XmlElement>? _programmes;
  static CancelToken? _cancelToken;

  static Future<EpgModel?> getEpg(Channel? model) async {
    if (model == null) return null;

    String channelKey = '';
    String channel = '';
    String date = '';
    final isHasXml = _programmes != null && _programmes!.isNotEmpty;
    LogUtil.v('加载EPG:::$isHasXml:::${_programmes?.length}');
    if (model.id != null && model.id != '' && isHasXml) {
      channelKey = model.id!;
    } else {
      channel = model.title!.replaceAll(' ', '').replaceAll('-', '');
      date = DateUtil.formatDate(DateTime.now(), format: "yyyyMMdd");
      channelKey = "$date-$channel";
    }

    if (_EPGMap.containsKey(channelKey)) {
      final cacheModel = _EPGMap[channelKey]!;
      LogUtil.v('命中EPG:::${cacheModel.toJson()}');
      return cacheModel;
    }

    if (isHasXml) {
      EpgModel epgModel = EpgModel(channelName: model.title, epgData: []);
      for (var programme in _programmes!) {
        final channel = programme.getAttribute('channel');
        if (channel == model.id) {
          final start = programme.getAttribute('start')!;
          final dateStart = DateUtil.formatDate(DateUtil.parseCustomDateTimeString(start), format: "HH:mm");
          final stop = programme.getAttribute('stop')!;
          final dateEnd = DateUtil.formatDate(DateUtil.parseCustomDateTimeString(stop), format: "HH:mm");
          final title = programme.findAllElements('title').first.innerText;
          epgModel.epgData!.add(EpgData(title: title, start: dateStart, end: dateEnd));
        }
      }
      if (epgModel.epgData!.isEmpty) return null;
      _EPGMap[channelKey] = epgModel;
      return epgModel;
    }

    try {
      _cancelToken?.cancel();
      _cancelToken ??= CancelToken();
      final epgRes = await HttpUtil().getRequest('https://epg.v1.mk/json?ch=$channel&date=$date', cancelToken: _cancelToken, isShowLoading: false);
      LogUtil.v('epgRes:::$epgRes');
      _cancelToken = null;
      if (epgRes != null) {
        LogUtil.v('epgRes:channelName::${epgRes['channel_name']}');
        if (channel.contains(epgRes['channel_name'])) {
          final epg = EpgModel.fromJson(epgRes);
          _EPGMap[channelKey] = epg;
          return epg;
        }
      }
    } catch (e) {
      LogUtil.v('epgRes:error::$e');
    }
    return null;
  }

  static loadEPGXML(String url) async {
    int index = 0;
    String uStr = url.replaceAll(' ', '').replaceAll('.xml/http', '.xml,http').replaceAll('.gz/http', '.gz,http');
    final urlLink = uStr.split(',');
    XmlDocument? tempXmlDocument;
    while (tempXmlDocument == null && index < urlLink.length) {
      final cUrl = urlLink[index];
      if (cUrl.endsWith('.gz')) {
        final res = await HttpUtil().getRequest(cUrl, isShowLoading: false, options: Options(responseType: ResponseType.bytes));
        if (res != null) {
          final zipper = GZip();
          final decRes = await zipper.decompress(res);
          String strRes = utf8.decode(decRes, allowMalformed: true);
          tempXmlDocument = XmlDocument.parse(strRes);
        } else {
          tempXmlDocument = null;
          index += 1;
        }
      } else {
        final res = await HttpUtil().getRequest(cUrl, isShowLoading: false);
        if (res != null) {
          tempXmlDocument = XmlDocument.parse(res.toString());
        } else {
          tempXmlDocument = null;
          index += 1;
        }
      }
    }
    _programmes = tempXmlDocument?.findAllElements('programme');
  }

  static resetEPGXML() {
    LogUtil.v('****reset EPG Xml ****');
    _programmes = null;
  }
}

class EpgModel {
  EpgModel({this.channelName, this.date, this.epgData});

  EpgModel.fromJson(dynamic json) {
    channelName = json['channel_name'];
    date = json['date'];
    if (json['epg_data'] != null) {
      epgData = [];
      json['epg_data'].forEach((v) {
        epgData!.add(EpgData.fromJson(v));
      });
    }
  }

  String? channelName;
  String? date;
  List<EpgData>? epgData;

  EpgModel copyWith({String? channelName, String? date, List<EpgData>? epgData}) =>
      EpgModel(channelName: channelName ?? this.channelName, date: date ?? this.date, epgData: epgData ?? this.epgData);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['channel_name'] = channelName;
    map['date'] = date;
    if (epgData != null) {
      map['epg_data'] = epgData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// desc : ""
/// end : "01:34"
/// start : "01:06"
/// title : "今日说法-2024-214"

class EpgData {
  EpgData({this.desc, this.end, this.start, this.title});

  EpgData.fromJson(dynamic json) {
    desc = json['desc'];
    end = json['end'];
    start = json['start'];
    title = json['title'];
  }

  String? desc;
  String? end;
  String? start;
  String? title;

  EpgData copyWith({String? desc, String? end, String? start, String? title}) =>
      EpgData(desc: desc ?? this.desc, end: end ?? this.end, start: start ?? this.start, title: title ?? this.title);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['desc'] = desc;
    map['end'] = end;
    map['start'] = start;
    map['title'] = title;
    return map;
  }
}
