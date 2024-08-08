import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

import 'env_util.dart';
import 'http_util.dart';

class CheckVersionUtil {
  static const version = '2.0.1';
  static final versionHost = EnvUtil.checkVersionHost();
  static final downloadLink = EnvUtil.sourceDownloadHost();
  static final releaseLink = EnvUtil.sourceReleaseHost();
  static final homeLink = EnvUtil.sourceHomeHost();
  static VersionEntity? latestVersionEntity;

  static Future<VersionEntity?> checkRelease([bool isShowLoading = true, isShowLatestToast = true]) async {
    if (latestVersionEntity != null) return latestVersionEntity;
    try {
      final res = await HttpUtil().getRequest(versionHost, isShowLoading: isShowLoading);
      if (res != null) {
        final latestVersion = res['tag_name'] as String?;
        final latestMsg = res['body'] as String?;
        if (latestVersion != null && latestVersion.compareTo(version) > 0) {
          latestVersionEntity = VersionEntity(latestVersion: latestVersion, latestMsg: latestMsg);
          return latestVersionEntity;
        } else {
          if (isShowLatestToast) EasyLoading.showToast('已是最新版');
          debugPrint('已是最新版::::::::');
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> showUpdateDialog(BuildContext context) async {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                  color: const Color(0xFF2B2D30),
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                      colors: [Color(0xff6D6875), Color(0xffB4838D), Color(0xffE5989B)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '发现新版本🚀',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    constraints: const BoxConstraints(minHeight: 200, minWidth: 300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🎒 v${CheckVersionUtil.latestVersionEntity!.latestVersion}更新内容',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text('${CheckVersionUtil.latestVersionEntity!.latestMsg}'),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(fixedSize: const Size(260, 44), backgroundColor: Colors.redAccent),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      '立即更新',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        });
  }

  static checkVersion(BuildContext context, [bool isShowLoading = true, isShowLatestToast = true]) async {
    final res = await checkRelease(isShowLoading, isShowLatestToast);
    if (res != null) {
      final isUpdate = await showUpdateDialog(context);
      if (isUpdate == true) {
        if (Platform.isIOS) {
          launchBrowserUrl('$downloadLink/${res!.latestVersion}/easyTV-${res!.latestVersion}.ipa');
        } else if (Platform.isAndroid) {
          launchBrowserUrl('$downloadLink/${res!.latestVersion}/easyTV-${res!.latestVersion}.apk');
        } else {
          launchBrowserUrl(releaseLink);
        }
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
