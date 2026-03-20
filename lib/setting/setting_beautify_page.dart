import 'package:easy_tv_live/provider/download_provider.dart';
import 'package:easy_tv_live/provider/theme_provider.dart';
import 'package:easy_tv_live/util/check_version_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingBeautifyPage extends StatelessWidget {
  const SettingBeautifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1F22),
      appBar: AppBar(title: const Text('实验设置'), backgroundColor: const Color(0xFF1E1F22), leading: const SizedBox.shrink()),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: [
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
              Builder(
                builder: (ctx) {
                  final provider = context.watch<DownloadProvider>();
                  return ListTile(
                    title: const Text('检查更新'),
                    trailing: CheckVersionUtil.latestVersionEntity == null
                        ? const Text('已是最新版本')
                        : provider.isDownloading
                        ? Text('新版本正在下载中...${(provider.progress * 100).toStringAsFixed(1)}%')
                        : Text('🔴 发现新版本：v${CheckVersionUtil.latestVersionEntity?.latestVersion}'),
                    onTap: () {
                      if (!context.read<DownloadProvider>().isDownloading) {
                        CheckVersionUtil.checkVersion(context, true, true);
                      }
                    },
                  );
                },
              ),
              if (!CheckVersionUtil.isTV)
                ListTile(
                  title: const Text('应用主页'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    CheckVersionUtil.launchBrowserUrl(CheckVersionUtil.homeLink);
                  },
                ),
              if (!CheckVersionUtil.isTV)
                ListTile(
                  title: const Text('发布历史'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    CheckVersionUtil.launchBrowserUrl(CheckVersionUtil.releaseLink);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
