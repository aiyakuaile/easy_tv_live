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
      appBar: AppBar(
        title: const Text('关于我们'),
        backgroundColor: const Color(0xFF1E1F22),
        leading: const SizedBox.shrink(),
      ),
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
              SwitchListTile(
                title: const Text('数据代理'),
                value: context.watch<ThemeProvider>().useDataProxy,
                subtitle: const Text('Github访问受限的用户需开启'),
                onChanged: (value) {
                  context.read<ThemeProvider>().setDataProxy(value);
                },
              ),
              Builder(builder: (ctx) {
                final provider = context.watch<DownloadProvider>();
                return ListTile(
                  title: const Text('检查更新'),
                  trailing: CheckVersionUtil.latestVersionEntity == null
                      ? const Text('已是最新版本')
                      : provider.isDownloading
                          ? Text(
                              '新版本正在下载中...${(provider.progress * 100).toStringAsFixed(1)}%',
                            )
                          : Text('🔴 发现新版本：v${CheckVersionUtil.latestVersionEntity?.latestVersion}'),
                  onTap: () {
                    if (!context.read<DownloadProvider>().isDownloading) {
                      CheckVersionUtil.checkVersion(context, true, true);
                    }
                  },
                );
              }),
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
