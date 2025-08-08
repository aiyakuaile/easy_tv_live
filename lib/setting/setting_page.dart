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
      appBar: AppBar(title: Text(S.current.settings)),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/images/logo.png', width: 80),
              const SizedBox(height: 12),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(S.current.appName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Positioned(
                    top: 0,
                    right: -45,
                    child: Text(
                      'v${CheckVersionUtil.version}',
                      style: TextStyle(fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
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
                const SizedBox(width: 10),
                const Icon(Icons.arrow_right),
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
          ListTile(
            title: const Text('远程配置'),
            leading: const Icon(Icons.settings_remote),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, RouterKeys.settingRemote);
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
          SwitchListTile(
            title: const Text('更新提示免打扰'),
            value: context.watch<ThemeProvider>().useLightVersionCheck,
            subtitle: const Text('开启后,播放页面的更新弹窗将会变成普通的消息提醒'),
            onChanged: (value) {
              context.read<ThemeProvider>().setLightVersionCheck(value);
            },
          ),
          SwitchListTile(
            title: const Text('自动更新'),
            value: context.watch<ThemeProvider>().useAutoUpdate,
            subtitle: const Text('发现新版本将会自动下载并安装'),
            onChanged: (value) {
              context.read<ThemeProvider>().setAutoUpdate(value);
            },
          ),
          ListTile(
            title: const Text('数据代理'),
            subtitle: const Text('Github访问受限的用户需开启'),
            trailing: DropdownButton(
              value: context.watch<ThemeProvider>().useDataValueProxy,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(value: 0, child: Text('关闭')),
                DropdownMenuItem(value: 1, child: Text('代理1')),
                DropdownMenuItem(value: 2, child: Text('代理2')),
              ],
              onChanged: (value) {
                if (value != null) {
                  context.read<ThemeProvider>().setDataValueProxy(value);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('超时自动切换线路'),
            subtitle: const Text('超过多少秒未播放则自动切换下一个线路'),
            trailing: DropdownButton(
              value: context.watch<ThemeProvider>().timeoutSwitchLine,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(value: 5, child: Text('5s')),
                DropdownMenuItem(value: 10, child: Text('10s')),
                DropdownMenuItem(value: 15, child: Text('15s')),
                DropdownMenuItem(value: 20, child: Text('20s')),
                DropdownMenuItem(value: 30, child: Text('30s')),
                DropdownMenuItem(value: 60, child: Text('60s')),
              ],
              onChanged: (value) {
                if (value != null) {
                  context.read<ThemeProvider>().setTimeoutSwitchLine(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
