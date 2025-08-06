import 'dart:async';
import 'dart:io';

import 'package:easy_tv_live/entity/play_channel_list_model.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/env_util.dart';
import 'package:easy_tv_live/util/http_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sp_util/sp_util.dart';

import '../entity/sub_scribe_model.dart';
import '../generated/l10n.dart';
import '../tv/tv_setting_page.dart';
import 'log_util.dart';

class M3uUtil {
  M3uUtil._();

  static final Map<String, Channel> _serialNumMap = {};

  static Map<String, Channel> get serialNumMap => _serialNumMap;

  static String? currentPlayChannelLink = '';

  // 获取默认的m3u文件
  static Future<PlayChannelListModel?> getDefaultM3uData() async {
    _serialNumMap.clear();
    String m3uData = '';
    final models = await getLocalData();
    if (models.isNotEmpty) {
      final defaultModel = models.firstWhere((element) => element.selected == true, orElse: () => models.first);
      currentPlayChannelLink = defaultModel.link;
      if (defaultModel.local == true) {
        File m3uFile = File(defaultModel.link!);
        final isExit = await m3uFile.exists();
        LogUtil.v('本地数据是否存在${defaultModel.link}::::::$isExit');
        if (isExit) {
          m3uData = await m3uFile.readAsString();
          await SpUtil.putString('m3u_cache', m3uData);
        } else {
          EasyLoading.showToast(S.current.noFile);
          return null;
        }
      } else {
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
      }
      if (m3uData.isEmpty) {
        return null;
      }
    } else {
      m3uData = await _fetchData();
      final defaultModel = SubScribeModel(
        time: DateUtil.formatDate(DateTime.now(), format: DateFormats.full),
        link: 'default',
        selected: true,
      );
      await saveLocalData([defaultModel]);
      currentPlayChannelLink = defaultModel.link;
    }
    final channelModels = await _parseM3u(m3uData);
    if (channelModels.playList!.isNotEmpty) {
      int index = 1;
      for (int i = 0; i < channelModels.playList!.length; i++) {
        final playModel = channelModels.playList![i];
        if (playModel.channel?.isNotEmpty ?? false) {
          for (int j = 0; j < playModel.channel!.length; j++) {
            final channel = playModel.channel![j];
            channel.serialNum = index;
            channel.groupIndex = i;
            channel.channelIndex = j;
            _serialNumMap[index.toString()] = channel;
            index += 1;
          }
        }
      }
    }
    return channelModels;
  }

  static Future<bool> isChangeChannelLink() async {
    final models = await getLocalData();
    final defaultModel = models.firstWhere((element) => element.selected == true, orElse: () => models.first);
    return currentPlayChannelLink != defaultModel.link;
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

  // 解析m3u文件
  static Future<PlayChannelListModel> _parseM3u(String m3u) async {
    final lines = m3u.split('\n');
    PlayChannelListModel playListModel = PlayChannelListModel(type: PlayListType.txt, playList: []);
    if (m3u.startsWith('#EXTM3U') || m3u.startsWith('#EXTINF')) {
      playListModel.type = PlayListType.m3u;
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
            final playModel = playListModel.playList!.firstWhere(
              (model) => model.group == tempGroupTitle,
              orElse: () {
                final model = PlayModel(group: tempGroupTitle, channel: []);
                playListModel.playList!.add(model);
                return model;
              },
            );
            final channel = playModel.channel!.firstWhere(
              (element) => element.title == tempChannelName,
              orElse: () {
                final model = Channel(id: tvgId, logo: tvgLogo, title: tempChannelName, urls: []);
                playModel.channel!.add(model);
                return model;
              },
            );
            final lineNext = lines[i + 1];
            if (isLiveLink(lineNext)) {
              channel.urls!.add(lineNext);
              i += 1;
            } else if (isLiveLink(lines[i + 2])) {
              channel.urls!.add(lines[i + 2].toString());
              i += 2;
            }
          }
        } else if (isLiveLink(line)) {
          playListModel.playList!
              .firstWhere((model) => model.group == tempGroupTitle)
              .channel!
              .firstWhere((element) => element.title == tempChannelName)
              .urls!
              .add(line);
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
            final playModel = playListModel.playList!.firstWhere(
              (model) => model.group == tempGroup,
              orElse: () {
                final model = PlayModel(group: tempGroup, channel: []);
                playListModel.playList!.add(model);
                return model;
              },
            );
            final channel = playModel.channel!.firstWhere(
              (element) => element.title == groupTitle,
              orElse: () {
                final model = Channel(id: groupTitle, title: groupTitle, urls: []);
                playModel.channel!.add(model);
                return model;
              },
            );
            channel.urls!.add(channelLink);
          } else {
            tempGroup = groupTitle == '' ? '${S.current.defaultText}${i + 1}' : groupTitle;
            int index = playListModel.playList!.indexWhere((e) => e.group == tempGroup);
            if (index == -1) {
              playListModel.playList!.add(PlayModel(group: tempGroup, channel: []));
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

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }
}
