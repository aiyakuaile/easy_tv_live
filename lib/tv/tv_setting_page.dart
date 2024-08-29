import 'package:easy_tv_live/setting/setting_font_page.dart';
import 'package:easy_tv_live/setting/subscribe_page.dart';
import 'package:flutter/material.dart';

import '../setting/setting_beautify_page.dart';

class TvSettingPage extends StatefulWidget {
  const TvSettingPage({super.key});

  @override
  State<TvSettingPage> createState() => _TvSettingPageState();
}

class _TvSettingPageState extends State<TvSettingPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('设置'),
            ),
            body: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.subscriptions),
                  title: const Text('订阅源'),
                  selected: _selectedIndex == 0,
                  autofocus: true,
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
                  leading: const Icon(Icons.brush),
                  title: const Text('美化'),
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
        ),
        if (_selectedIndex == 0)
          const Expanded(
            child: SubScribePage(isTV: true),
          ),
        if (_selectedIndex == 1) const Expanded(child: SettingFontPage(isTV: true)),
        if (_selectedIndex == 2) const Expanded(child: SettingBeautifyPage(isTV: true)),
      ],
    );
  }
}
