import 'dart:convert';
import 'dart:io';

import 'package:easy_tv_live/entity/remote_model.dart';
import 'package:easy_tv_live/provider/theme_provider.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import 'http_util.dart';

class RemoteUtil {
  RemoteUtil._();
  static Future<bool> getRemoteData(BuildContext context, [bool isShowLoading = true]) async {
    final themeProvider = context.read<ThemeProvider>();
    final isOpenRemoteControl = themeProvider.isOpenRemoteControl;
    if (isOpenRemoteControl) {
      LogUtil.v('请求远程配置项::::::');
      try {
        final res = await HttpUtil().getRequest(themeProvider.remoteControlLink!, isShowLoading: isShowLoading);
        Map<String, dynamic>? resJson;
        if (res is Map<String, dynamic>) {
          resJson = res;
        } else if (res is String) {
          resJson = json.decode(res) as Map<String, dynamic>?;
        } else {
          EasyLoading.showToast('远程配置无法解析');
          return false;
        }
        if (resJson != null) {
          final oldDtaId = SpUtil.getInt('remoteDtaId', defValue: -1);
          if (resJson['dtaId'] != oldDtaId) {
            LogUtil.v('开始应用远程配置项::::::');
            final remoteModel = RemoteModel.fromJson(resJson);
            await themeProvider.setRemoteData(remoteModel);
          } else {
            LogUtil.v('远程配置dtaId未变更，本次使用本地设置::::::');
          }
          return true;
        }
      } on Exception catch (e) {
        LogUtil.v('请求远程配置项失败::::::$e');
        EasyLoading.showToast(e.toString());
        return false;
      }
    } else {
      LogUtil.v('未开启远程配置::::::');
    }
    EasyLoading.dismiss();
    return false;
  }

  static Future<String?> getCurrentIP() async {
    String? currentIP = '';
    try {
      currentIP = await NetworkInfo().getWifiIP();
    } catch (e) {
      LogUtil.v(e.toString());
    }
    if (currentIP == null || currentIP == '') {
      try {
        for (var interface in await NetworkInterface.list()) {
          for (var addr in interface.addresses) {
            LogUtil.v('Name: ${interface.name}  IP Address: ${addr.address}  IPV4: ${InternetAddress.anyIPv4}');
            if (addr.type == InternetAddressType.IPv4 && addr.address.startsWith('192')) {
              currentIP = addr.address;
            }
          }
        }
      } catch (e) {
        LogUtil.v(e.toString());
      }
    }
    return currentIP;
  }
}
