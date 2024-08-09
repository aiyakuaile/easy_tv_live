import 'dart:io';

import 'package:easy_tv_live/setting_page.dart';
import 'package:easy_tv_live/subscribe/subscribe_page.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sp_util/sp_util.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'live_home_page.dart';
import 'router_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();
  LogUtil.init(isDebug: true, tag: 'EasyTV');
  await SpUtil.getInstance();
  runApp(const MyApp());
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '极简TV',
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Kaiti', useMaterial3: true),
      routes: {
        RouterKeys.subScribe: (BuildContext context) => const SubScribePage(),
        RouterKeys.setting: (BuildContext context) => const SettingPage()
      },
      home: const LiveHomePage(),
      builder: EasyLoading.init(),
    );
  }
}
