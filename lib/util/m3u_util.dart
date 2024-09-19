import 'dart:async';

import 'package:easy_tv_live/entity/playlist_model.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/env_util.dart';
import 'package:easy_tv_live/util/http_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sp_util/sp_util.dart';

import '../entity/subScribe_model.dart';
import '../generated/l10n.dart';
import '../tv/tv_setting_page.dart';
import 'log_util.dart';

class M3uUtil {
  M3uUtil._();
  // 获取默认的m3u文件
  static Future<PlaylistModel?> getDefaultM3uData() async {
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
        return null;
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
      EasyLoading.showToast(S.current.getDefaultError);
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
  // {
  //     "epgUrl": "http://epg.xml",
  //     "playList": {
  //         "央视": {
  //             "CCTV-1": {
  //                 "id": "cctv1",
  //                 "logo": "https://tv.cctv.com/live/cctv1/logo.png",
  //                 "title": "CCTV-1"
  //                 "urls": [
  //                     "http://live.cctv.com/live/cctv1/index.m3u8"
  //                 ]
  //             },
  //         }
  //     }
  // }
  static Future<PlaylistModel> _parseM3u(String m3u) async {
    final lines = m3u.split('\n');
    final playListModel = PlaylistModel();
    playListModel.playList = <String, Map<String, PlayModel>>{};
    if (m3u.startsWith('#EXTM3U') || m3u.startsWith('#EXTINF')) {
      String tempGroupTitle = '';
      String tempChannelName = '';
      for (int i = 0; i < lines.length - 1; i++) {
        String line = lines[i];
        if (line.startsWith('#EXTM3U')) {
          List<String> params = line.replaceAll('"', '').split(' ');
          final tvgUrl = params.firstWhere((element) => element.startsWith('x-tvg-url'), orElse: () => '');
          if (tvgUrl.isNotEmpty) {
            playListModel.epgUrl = tvgUrl.split('=').last;
          }
        } else if (line.startsWith('#EXTINF:')) {
          if (line.startsWith('#EXTINF:-1,')) {
            line = line.replaceFirst('#EXTINF:-1,', '#EXTINF:-1 ');
          }
          final lineList = line.split(',');
          List<String> params = lineList.first.replaceAll('"', '').split(' ');
          final groupStr = params.firstWhere((element) => element.startsWith('group-title='), orElse: () => 'group-title=${S.current.defaultText}');
          String tvgLogo = params.firstWhere((element) => element.startsWith('tvg-logo='), orElse: () => '');
          String tvgId = params.firstWhere((element) => element.startsWith('tvg-name='), orElse: () => '');
          if (tvgId.isEmpty) {
            tvgId = params.firstWhere((element) => element.startsWith('tvg-id='), orElse: () => '');
          }
          if (tvgId.isNotEmpty) {
            tvgId = tvgId.split('=').last;
          }
          if (tvgLogo.isNotEmpty) {
            tvgLogo = tvgLogo.split('=').last;
          }
          if (groupStr.isNotEmpty) {
            tempGroupTitle = groupStr.split('=').last;
            tempChannelName = lineList.last;
            Map<String, PlayModel> group = playListModel.playList![tempGroupTitle] ?? {};
            PlayModel groupList =
                group[tempChannelName] ?? PlayModel(id: tvgId, group: tempGroupTitle, logo: tvgLogo, title: tempChannelName, urls: []);
            final lineNext = lines[i + 1];
            if (isLiveLink(lineNext)) {
              groupList.urls!.add(lineNext);
              group[tempChannelName] = groupList;
              playListModel.playList![tempGroupTitle] = group;
              i += 1;
            } else if (isLiveLink(lines[i + 2])) {
              groupList.urls!.add(lines[i + 2].toString());
              group[tempChannelName] = groupList;
              playListModel.playList![tempGroupTitle] = group;
              i += 2;
            }
          }
        } else if (isLiveLink(line)) {
          playListModel.playList![tempGroupTitle]![tempChannelName]!.urls!.add(line);
        }
      }
    } else {
      String tempGroup = S.current.defaultText;
      for (int i = 0; i < lines.length - 1; i++) {
        final line = lines[i];
        final lineList = line.split(',');
        if (lineList.length >= 2) {
          final groupTitle = lineList[0];
          final channelLink = lineList[1];
          if (isLiveLink(channelLink)) {
            Map<String, PlayModel> group = playListModel.playList![tempGroup] ?? <String, PlayModel>{};
            final chanelList = group[groupTitle] ?? PlayModel(group: tempGroup, id: groupTitle, title: groupTitle, urls: []);
            chanelList.urls!.add(channelLink);
            group[groupTitle] = chanelList;
            playListModel.playList![tempGroup] = group;
          } else {
            tempGroup = groupTitle == '' ? '${S.current.defaultText}${i + 1}' : groupTitle;
            if (playListModel.playList![tempGroup] == null) {
              playListModel.playList![tempGroup] = <String, PlayModel>{};
            }
          }
        }
      }
    }

    if (playListModel.playList!.isEmpty) {
      EasyLoading.showError(S.current.parseError);
    }

    return playListModel;
  }

  static Future<bool?> openAddSource(BuildContext context) async {
    return Navigator.push<bool>(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const TvSettingPage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, -1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
