import 'package:easy_tv_live/setting/setting_font_page.dart';
import 'package:easy_tv_live/setting/subscribe_page.dart';
import 'package:easy_tv_live/tv/tv_appreciate_page.dart';
import 'package:easy_tv_live/util/check_version_util.dart';
import 'package:easy_tv_live/util/env_util.dart';
import 'package:flutter/material.dart';

import '../setting/setting_beautify_page.dart';

class TvSettingPage extends StatefulWidget {
  const TvSettingPage({super.key});

  @override
  State<TvSettingPage> createState() => _TvSettingPageState();
}

class _TvSettingPageState extends State<TvSettingPage> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 240,
          child: Scaffold(
            appBar: AppBar(title: const Text('设置')),
            body: Column(
              children: [
                Flexible(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.card_giftcard),
                        title: const Text('扫码赞赏'),
                        selected: _selectedIndex == -1,
                        autofocus: EnvUtil.isTV() ? true : false,
                        onTap: () {
                          setState(() {
                            _selectedIndex = -1;
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.subscriptions),
                        title: const Text('订阅资源'),
                        selected: _selectedIndex == 0,
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.font_download),
                        title: const Text('字体设置'),
                        selected: _selectedIndex == 1,
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.account_balance_outlined),
                        title: Text('实验设置 ${CheckVersionUtil.latestVersionEntity == null ? '' : '🔴'}'),
                        selected: _selectedIndex == 2,
                        onTap: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(alignment: Alignment.centerLeft, padding: const EdgeInsets.only(left: 16), child: Text('V${CheckVersionUtil.version}')),
              ],
            ),
          ),
        ),
        if (_selectedIndex == -1) const Expanded(child: TvAppreciatePage()),
        if (_selectedIndex == 0) const Expanded(child: SubScribePage(isTV: true)),
        if (_selectedIndex == 1) const Expanded(child: SettingFontPage(isTV: true)),
        if (_selectedIndex == 2) const Expanded(child: SettingBeautifyPage()),
      ],
    );
  }
}
