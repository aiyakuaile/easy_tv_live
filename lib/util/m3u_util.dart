import 'dart:async';

import 'package:easy_tv_live/subscribe/subScribe_model.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/env_util.dart';
import 'package:easy_tv_live/util/http_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sp_util/sp_util.dart';

import 'log_util.dart';

class M3uUtil {
  M3uUtil._();
  // 获取默认的m3u文件
  static Future<Map<String, dynamic>> getDefaultM3uData() async {
    String m3uData = '';
    final models = await getLocalData();
    if (models.isNotEmpty) {
      final defaultModel = models.firstWhere((element) => element.selected == true, orElse: () => models.first);
      final newRes = await HttpUtil().getRequest(defaultModel.link == 'default' ? EnvUtil.videoDefaultChannelHost() : defaultModel.link!);
      if (newRes != null) {
        LogUtil.v('已获取新数据::::::');
        m3uData = newRes;
        await SpUtil.putString('m3u_cache', m3uData);
      } else {
        final oldRes = SpUtil.getString('m3u_cache', defValue: '');
        if (oldRes != '') {
          LogUtil.v('已获取到历史保存的数据::::::');
          m3uData = oldRes!;
        }
      }
      if (m3uData.isEmpty) {
        return <String, dynamic>{};
      }
    } else {
      m3uData = await _fetchData();
      await saveLocalData([SubScribeModel(time: DateUtil.formatDate(DateTime.now(), format: DateFormats.full), link: 'default', selected: true)]);
    }
    return _parseM3u(m3uData);
  }

  // 获取本地m3u数据
  static Future<List<SubScribeModel>> getLocalData() async {
    Completer completer = Completer();
    List<SubScribeModel> m3uList = SpUtil.getObjList('local_m3u', (v) => SubScribeModel.fromJson(v), defValue: <SubScribeModel>[])!;
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
    final defaultM3u = EnvUtil.videoDefaultChannelHost();
    final res = await HttpUtil().getRequest(defaultM3u);
    if (res == null) {
      EasyLoading.showToast('获取默认数据源失败');
      return '';
    } else {
      return res;
    }
  }

  static bool isLiveLink(String link) {
    final tLink = link.toLowerCase();
    if (tLink.startsWith('http') || tLink.startsWith('r') || tLink.startsWith('p') || tLink.startsWith('s') || tLink.startsWith('w')) {
      return true;
    }
    return false;
  }

  // 解析m3u文件为Map
  static Future<Map<String, dynamic>> _parseM3u(String m3u) async {
    final lines = m3u.split('\n');
    final result = <String, dynamic>{};
    if (m3u.startsWith('#EXTM3U')) {
      String tempGroupTitle = '';
      String tempChannelName = '';
      for (int i = 0; i < lines.length - 1; i++) {
        final line = lines[i];
        if (line.startsWith('#EXTINF:')) {
          final lineList = line.split(',');
          List<String> params = lineList.first.replaceAll('"', '').split(' ');
          final groupStr = params.firstWhere((element) => element.startsWith('group-title='), orElse: () => 'group-title=默认');
          if (groupStr.isNotEmpty) {
            tempGroupTitle = groupStr.split('=').last;
            tempChannelName = lineList.last;
            Map group = result[tempGroupTitle] ?? {};
            List groupList = group[tempChannelName] ?? [];
            final lineNext = lines[i + 1];
            if (isLiveLink(lineNext)) {
              groupList.add(lineNext);
              group[tempChannelName] = groupList;
              result[tempGroupTitle] = group;
              i += 1;
            } else if (isLiveLink(lines[i + 2])) {
              groupList.add(lines[i + 2].toString());
              group[tempChannelName] = groupList;
              result[tempGroupTitle] = group;
              i += 2;
            }
          }
        } else if (isLiveLink(line)) {
          Map group = result[tempGroupTitle] ?? {};
          List groupList = group[tempChannelName] ?? [];
          groupList.add(line);
          group[tempChannelName] = groupList;
          result[tempGroupTitle] = group;
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
          if (isLiveLink(channelLink)) {
            Map<String, List<String>> group = result[tempGroup] ?? <String, List<String>>{};
            List<String> chanelList = group[groupTitle] ?? <String>[];
            chanelList.add(channelLink);
            group[groupTitle] = chanelList;
            result[tempGroup] = group;
          } else {
            tempGroup = groupTitle == '' ? '默认${i + 1}' : groupTitle;
            if (result[tempGroup] == null) {
              result[tempGroup] = <String, List<String>>{};
            }
          }
        }
      }
    }

    if (result.isEmpty) {
      EasyLoading.showError('解析数据源失败');
    }

    return result;
  }
}
