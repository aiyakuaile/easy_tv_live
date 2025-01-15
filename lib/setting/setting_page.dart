import 'package:easy_tv_live/router_keys.dart';
import 'package:easy_tv_live/util/check_version_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../provider/theme_provider.dart';

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
        title: Text(S.current.settings),
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
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(
                    S.current.appName,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Positioned(
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
            title: Text(S.current.homePage),
            leading: const Icon(Icons.home_filled),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              CheckVersionUtil.launchBrowserUrl(CheckVersionUtil.homeLink);
            },
          ),
          ListTile(
            title: Text(S.current.releaseHistory),
            leading: const Icon(Icons.history),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              CheckVersionUtil.launchBrowserUrl(CheckVersionUtil.releaseLink);
            },
          ),
          ListTile(
            title: Text(S.current.checkUpdate),
            leading: const Icon(Icons.tips_and_updates),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_latestVersionEntity != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      S.current.newVersion(_latestVersionEntity!.latestVersion!),
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
          ListTile(
            title: const Text('赞赏榜'),
            leading: const Icon(Icons.card_giftcard),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, RouterKeys.settingReward);
            },
          ),
          ListTile(
            title: const Text('字体'),
            leading: const Icon(Icons.text_fields),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, RouterKeys.settingFont);
            },
          ),
          SwitchListTile(
            autofocus: true,
            title: const Text('背景美化'),
            value: context.watch<ThemeProvider>().isBingBg,
            subtitle: const Text('未播放时的屏幕背景,每日更换图片'),
            onChanged: (value) {
              context.read<ThemeProvider>().setBingBg(value);
            },
          ),
        ],
      ),
    );
  }
}
