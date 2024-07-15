import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_tv_live/util/env_util.dart';
import 'package:easy_tv_live/util/http_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

const version = '2.0.0';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String? _latestVersion;
  final downloadLink = EnvUtil.sourceDownloadHost();
  final releaseLink = EnvUtil.sourceReleaseHost();
  final homeLink = EnvUtil.sourceHomeHost();

  _launchUrl(String url) async {
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  _checkUpdate() async {
    if (_latestVersion != null) {
      if (Platform.isIOS) {
        _launchUrl('$downloadLink/$_latestVersion/easyTV-$_latestVersion.ipa');
      } else if (Platform.isAndroid) {
        _launchUrl('$downloadLink/$_latestVersion/easyTV-$_latestVersion.apk');
      } else {
        _launchUrl(releaseLink);
      }
      return;
    }
    const githubToken = String.fromEnvironment('github');
    try {
      final res = await HttpUtil()
          .getRequest('https://api.github.com/repos/aiyakuaile/easy_tv_live/releases/latest',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $githubToken',
                },
              ));
      if (res != null) {
        final latestVersion = res['tag_name'] as String?;
        if (latestVersion != null && latestVersion.compareTo(version) > 0) {
          setState(() {
            _latestVersion = latestVersion;
          });
          EasyLoading.showInfo('有新版本v$latestVersion');
        } else {
          EasyLoading.showInfo('已是最新版本');
        }
      }
    } catch (e) {
      EasyLoading.showError('检查失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/logo.png',
                width: 80,
              ),
              const SizedBox(
                height: 12,
              ),
              const Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(
                    '极简TV',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Positioned(
                    top: 0,
                    right: -45,
                    child: Text(
                      'v$version',
                      style: TextStyle(
                          fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
          ListTile(
            title: const Text('主页'),
            leading: const Icon(Icons.home_filled),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              _launchUrl(homeLink);
            },
          ),
          ListTile(
            title: const Text('发布历史'),
            leading: const Icon(Icons.history),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              _launchUrl(releaseLink);
            },
          ),
          ListTile(
            title: const Text('检查更新'),
            leading: const Icon(Icons.tips_and_updates),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_latestVersion != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.redAccent, borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      '立即下载v$_latestVersion',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.arrow_right)
              ],
            ),
            onTap: _checkUpdate,
          ),
        ],
      ),
    );
  }
}
