import 'dart:async';

import 'package:easy_tv_live/subscribe/subScribe_model.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/http_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sp_util/sp_util.dart';

class M3uUtil {
  M3uUtil._();

  static String defaultM3u =
      'https://mirror.ghproxy.com/raw.githubusercontent.com/joevess/IPTV/main/sources/iptv_sources.m3u8';

  // 获取默认的m3u文件
  static Future<Map<String, dynamic>> getDefaultM3uData() async {
    String m3uData = '';
    final models = await getLocalData();
    if (models.isEmpty) {
      m3uData = await _fetchData();
      await saveLocalData([
        SubScribeModel(
            time: DateUtil.formatDate(DateTime.now(), format: DateFormats.full),
            link: 'default',
            result: m3uData,
            selected: true)
      ]);
    } else {
      // LogUtil.v('models===${models.map((e) => e.toJson())}');
      final subScribeModel =
          models.firstWhere((element) => element.selected == true, orElse: () => models.first);
      m3uData = subScribeModel.result!;
    }
    return _parseM3u(m3uData);
  }

  // 获取本地m3u数据
  static Future<List<SubScribeModel>> getLocalData() async {
    Completer completer = Completer();
    List<SubScribeModel> m3uList = SpUtil.getObjList('local_m3u', (v) => SubScribeModel.fromJson(v),
        defValue: <SubScribeModel>[])!;
    completer.complete(m3uList);
    final res = await completer.future;
    return res;
  }

  // 保存本地m3u数据
  static Future<bool> saveLocalData(List<SubScribeModel> models) async {
    final res = await SpUtil.putObjectList('local_m3u', models.map((e) => e.toJson()).toList());
    return res ?? false;
  }

  static Future<String> _fetchData() async {
    final res = await HttpUtil().getRequest(defaultM3u);
    if (res == null) {
      return rootBundle.loadString('assets/resources/default.m3u8');
    } else {
      return res;
    }
  }

  // 刷新m3u文件
  static Future<String> refreshM3uLink(String link, {bool isAdd = false}) async {
    debugPrint('refreshM3uLink=======$link');
    final res = await HttpUtil().getRequest(link);
    debugPrint('res=======$res');
    if (res == null) {
      EasyLoading.showToast('请添加.m3u或者.txt文件链接');
      return '';
    } else {
      return res;
    }
  }

  // 解析m3u文件为Map
  static Future<Map<String, dynamic>> _parseM3u(String m3u) async {
    final lines = m3u.split('\n');
    final result = <String, dynamic>{};
    if (m3u.startsWith('#EXTM3U')) {
      for (int i = 0; i < lines.length - 1; i++) {
        final line = lines[i];
        if (line.startsWith('#EXTINF:')) {
          final lineList = line.split(',');
          List<String> params = lineList.first.replaceAll('"', '').split(' ');
          final groupStr =
              params.firstWhere((element) => element.startsWith('group-title='), orElse: () => '');
          if (groupStr.isNotEmpty) {
            final groupTitle = groupStr.split('=').last;
            final channelName = lineList.last;
            Map group = result[groupTitle] ?? {};
            List groupList = group[channelName] ?? [];
            final lineNext = lines[i + 1];
            if (lineNext.startsWith('http')) {
              groupList.add(lineNext);
              group[channelName] = groupList;
              result[groupTitle] = group;
              i += 1;
            } else if (lines[i + 2].startsWith('http')) {
              groupList.add(lines[i + 2].toString());
              group[channelName] = groupList;
              result[groupTitle] = group;
              i += 2;
            }
          }
        }
      }
    } else {
      String tempGroup = '默认';
      for (int i = 0; i < lines.length - 1; i++) {
        final line = lines[i];
        final lineList = line.split(',');
        if (lineList.length >= 2) {
          final groupTitle = lineList[0];
          final channelLink = lineList[1];
          if (!channelLink.startsWith('http')) {
            tempGroup = groupTitle;
            if (result[groupTitle] == null) {
              result[groupTitle] = <String, List<String>>{};
            }
          } else {
            Map<String, List<String>> group = result[tempGroup] ?? <String, List<String>>{};
            List<String> chanelList = group[groupTitle] ?? <String>[];
            chanelList.add(channelLink);
            group[groupTitle] = chanelList;
            result[tempGroup] = group;
          }
        } else {
          EasyLoading.showToast('解析数据源出错了');
          return result;
        }
      }
    }
    return result;
  }
}
