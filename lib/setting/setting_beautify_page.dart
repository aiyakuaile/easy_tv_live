import 'package:easy_tv_live/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingBeautifyPage extends StatelessWidget {
  final bool isTV;
  const SettingBeautifyPage({super.key, this.isTV = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isTV ? const Color(0xFF1E2022) : null,
      appBar: AppBar(
        title: const Text('美化'),
        backgroundColor: isTV ? const Color(0xFF1E2022) : null,
        leading: isTV ? const SizedBox.shrink() : null,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: [
              SwitchListTile(
                autofocus: true,
                title: const Text('每日Bing'),
                value: context.watch<ThemeProvider>().isBingBg,
                subtitle: const Text('未播放时的屏幕背景,每日更换图片'),
                onChanged: (value) {
                  context.read<ThemeProvider>().setBingBg(value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
