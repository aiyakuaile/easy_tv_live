import 'dart:convert';
import 'dart:io';

import 'package:easy_tv_live/widget/update_download_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

import '../generated/l10n.dart';
import 'env_util.dart';
import 'http_util.dart';
import 'log_util.dart';

class CheckVersionUtil {
  static const version = '2.9.8';
  static final releaseLink = EnvUtil.sourceReleaseHost();
  static final homeLink = EnvUtil.sourceHomeHost();
  static VersionEntity? latestVersionEntity;
  static bool isTV = EnvUtil.isTV();

  static Future<String?> checkVersionAndAutoUpdate() async {
    final latestVersionEntity = await checkRelease(false, false);
    if (latestVersionEntity != null) {
      final url =
          '${EnvUtil.sourceDownloadHost()}/${latestVersionEntity.latestVersion}/easyTV-${latestVersionEntity.latestVersion}${isTV ? '-tv' : ''}.apk';
      return url;
    }
    return null;
  }

  static checkLightVersion() async {
    final latestVersionEntity = await checkRelease(false, false);
    if (latestVersionEntity != null) {
      EasyLoading.showToast('发现新版本，请及时更新哦！', toastPosition: EasyLoadingToastPosition.top);
    }
  }

  static Future<VersionEntity?> checkRelease([bool isShowLoading = true, isShowLatestToast = true]) async {
    if (latestVersionEntity != null) return latestVersionEntity;
    try {
      final res = await HttpUtil().getRequest(EnvUtil.checkVersionHost(), isShowLoading: isShowLoading);
      if (res != null) {
        final resMap = json.decode(res);
        final latestVersion = resMap['latest_version'] as String?;
        final latestMsg = (resMap['update_log'] as List?)?.join('\n');
        if (latestVersion != null && latestVersion.compareTo(version) > 0) {
          latestVersionEntity = VersionEntity(latestVersion: latestVersion, latestMsg: latestMsg);
          return latestVersionEntity;
        } else {
          if (isShowLatestToast) EasyLoading.showToast(S.current.latestVersion, toastPosition: EasyLoadingToastPosition.top);
          LogUtil.v('已是最新版::::::::');
        }
      }
      return null;
    } catch (e) {
      LogUtil.e('检查更新错误:::::$e');
      return null;
    }
  }

  static Future<bool?> showUpdateDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: isTV || !EnvUtil.isMobile ? 600 : 300,
            decoration: BoxDecoration(
              color: const Color(0xFF2B2D30),
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [Color(0xff6D6875), Color(0xffB4838D), Color(0xffE5989B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Text('${S.current.findNewVersion}🚀', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  constraints: const BoxConstraints(minHeight: 200, minWidth: 300),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🎒 v${CheckVersionUtil.latestVersionEntity!.latestVersion}${S.current.updateContent}',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Padding(padding: const EdgeInsets.all(20), child: Text('${CheckVersionUtil.latestVersionEntity!.latestMsg}')),
                    ],
                  ),
                ),
                UpdateDownloadBtn(
                  apkUrl:
                      '${EnvUtil.sourceDownloadHost()}/${latestVersionEntity!.latestVersion}/easyTV-${latestVersionEntity!.latestVersion}${isTV ? '-tv' : ''}'
                      '.apk',
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  static checkVersion(BuildContext context, [bool isShowLoading = true, isShowLatestToast = true]) async {
    final res = await checkRelease(isShowLoading, isShowLatestToast);
    if (res != null && context.mounted) {
      final isUpdate = await showUpdateDialog(context);
      if (isUpdate == true && !Platform.isAndroid) {
        launchBrowserUrl(releaseLink);
      }
    }
  }

  static launchBrowserUrl(String url) async {
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}

class VersionEntity {
  final String? latestVersion;
  final String? latestMsg;

  VersionEntity({this.latestVersion, this.latestMsg});
}
