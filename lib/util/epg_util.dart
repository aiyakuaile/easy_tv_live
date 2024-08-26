import 'package:dio/dio.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/http_util.dart';
import 'package:easy_tv_live/util/log_util.dart';

/// channel_name : "CCTV1"
/// date : ""
/// epg_data : []
class EpgUtil {
  EpgUtil._();

  static final _EPGMap = <String, EpgModel>{};
  static CancelToken? _cancelToken;

  static Future<EpgModel?> getEpg(String channelName) async {
    final channel = channelName.replaceAll(' ', '').replaceAll('-', '');
    final date = DateUtil.formatDate(DateTime.now(), format: "yyMMdd");
    final _channelKey = "$date-$channel".hashCode.toString();
    if (_EPGMap.containsKey(_channelKey)) {
      return _EPGMap[_channelKey]!;
    } else {
      _cancelToken?.cancel();
      _cancelToken ??= CancelToken();
      final epgRes = await HttpUtil().getRequest('https://epg.v1.mk/json?ch=$channel&date=$date', cancelToken: _cancelToken, isShowLoading: false);
      LogUtil.v('epgRes:::$epgRes');
      _cancelToken = null;
      if (epgRes != null) {
        LogUtil.v('epgRes:channelName::${epgRes['channel_name']}');
        if (channel.contains(epgRes['channel_name'])) {
          final epg = EpgModel.fromJson(epgRes);
          _EPGMap[_channelKey] = epg;
          return epg;
        }
      }
      return null;
    }
  }
}

class EpgModel {
  EpgModel({
    this.channelName,
    this.date,
    this.epgData,
  });

  EpgModel.fromJson(dynamic json) {
    channelName = json['channel_name'];
    date = json['date'];
    if (json['epg_data'] != null) {
      epgData = [];
      json['epg_data'].forEach((v) {
        epgData?.add(EpgData.fromJson(v));
      });
    }
  }

  String? channelName;
  String? date;
  List<EpgData>? epgData;

  EpgModel copyWith({
    String? channelName,
    String? date,
    List<EpgData>? epgData,
  }) =>
      EpgModel(
        channelName: channelName ?? this.channelName,
        date: date ?? this.date,
        epgData: epgData ?? this.epgData,
      );

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
  EpgData({
    this.desc,
    this.end,
    this.start,
    this.title,
  });

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

  EpgData copyWith({
    String? desc,
    String? end,
    String? start,
    String? title,
  }) =>
      EpgData(
        desc: desc ?? this.desc,
        end: end ?? this.end,
        start: start ?? this.start,
        title: title ?? this.title,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['desc'] = desc;
    map['end'] = end;
    map['start'] = start;
    map['title'] = title;
    return map;
  }
}
