import 'dart:io';

import 'package:easy_tv_live/provider/theme_provider.dart';
import 'package:easy_tv_live/setting/qr_scan_page.dart';
import 'package:easy_tv_live/setting/reward_page.dart';
import 'package:easy_tv_live/setting/setting_font_page.dart';
import 'package:easy_tv_live/setting/subscribe_page.dart';
import 'package:easy_tv_live/util/env_util.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fvp/fvp.dart' as fvp;
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:window_manager/window_manager.dart';

import 'generated/l10n.dart';
import 'live_home_page.dart';
import 'provider/download_provider.dart';
import 'router_keys.dart';
import 'setting/setting_beautify_page.dart';
import 'setting/setting_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!EnvUtil.isMobile) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(900, 900 * 9 / 16),
      minimumSize: Size(300, 300 * 9 / 16),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      title: '极简TV',
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  WakelockPlus.enable();
  LogUtil.init(isDebug: kDebugMode, tag: 'EasyTV');
  await SpUtil.getInstance();
  fvp.registerWith(options: {
    'platforms': ['android', 'ios', 'windows', 'linux', 'macos'],
    'video.decoders': ['FFmpeg']
  });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => DownloadProvider()),
    ],
    child: const MyApp(),
  ));
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, ({String fontFamily, double textScaleFactor})>(
      selector: (_, provider) => (fontFamily: provider.fontFamily, textScaleFactor: provider.textScaleFactor),
      builder: (context, data, child) {
        String? fontFamily = data.fontFamily;
        if (fontFamily == 'system') {
          fontFamily = null;
        }
        return MaterialApp(
          title: '极简TV',
          theme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: fontFamily,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent, brightness: Brightness.dark),
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
              ),
              useMaterial3: true),
          routes: {
            RouterKeys.subScribe: (BuildContext context) => const SubScribePage(),
            RouterKeys.setting: (BuildContext context) => const SettingPage(),
            RouterKeys.settingFont: (BuildContext context) => const SettingFontPage(),
            RouterKeys.settingBeautify: (BuildContext context) => const SettingBeautifyPage(),
            RouterKeys.settingReward: (BuildContext context) => const RewardPage(),
            RouterKeys.settingQrScan: (BuildContext context) => const QrScanPage(),
          },
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) {
            if (locale == null) {
              return const Locale('en', 'US');
            }
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode != locale.countryCode) {
                return supportedLocale;
              }
            }
            return const Locale('en', 'US');
          },
          debugShowCheckedModeBanner: false,
          home: Platform.isWindows || Platform.isLinux ? const DragToResizeArea(child: DragToMoveArea(child: LiveHomePage())) : const LiveHomePage(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(data.textScaleFactor)),
              child: FlutterEasyLoading(child: child),
            );
          },
        );
      },
    );
  }
}
