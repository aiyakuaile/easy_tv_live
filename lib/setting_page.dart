import 'package:easy_tv_live/util/check_version_util.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  VersionEntity? _latestVersionEntity = CheckVersionUtil.latestVersionEntity;

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
                      'v${CheckVersionUtil.version}',
                      style: TextStyle(fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.bold),
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
              CheckVersionUtil.launchBrowserUrl(CheckVersionUtil.homeLink);
            },
          ),
          ListTile(
            title: const Text('发布历史'),
            leading: const Icon(Icons.history),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              CheckVersionUtil.launchBrowserUrl(CheckVersionUtil.releaseLink);
            },
          ),
          ListTile(
            title: const Text('检查更新'),
            leading: const Icon(Icons.tips_and_updates),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_latestVersionEntity != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      '新版本v${_latestVersionEntity!.latestVersion}',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.arrow_right)
              ],
            ),
            onTap: () async {
              await CheckVersionUtil.checkVersion(context);
              setState(() {
                _latestVersionEntity = CheckVersionUtil.latestVersionEntity;
              });
            },
          ),
        ],
      ),
    );
  }
}
