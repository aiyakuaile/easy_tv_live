// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `极简TV`
  String get appName {
    return Intl.message('极简TV', name: 'appName', desc: '', args: []);
  }

  /// `正在加载`
  String get loading {
    return Intl.message('正在加载', name: 'loading', desc: '', args: []);
  }

  /// `线路{line}播放: {channel}`
  String lineToast(Object line, Object channel) {
    return Intl.message(
      '线路$line播放: $channel',
      name: 'lineToast',
      desc: '',
      args: [line, channel],
    );
  }

  /// `{channel}：无法播放，请更换其它频道`
  String playError(Object channel) {
    return Intl.message(
      '$channel：无法播放，请更换其它频道',
      name: 'playError',
      desc: '',
      args: [channel],
    );
  }

  /// `切换线路{line} ...`
  String switchLine(Object line) {
    return Intl.message(
      '切换线路$line ...',
      name: 'switchLine',
      desc: '',
      args: [line],
    );
  }

  /// `出错了，尝试重新连接...`
  String get playReconnect {
    return Intl.message(
      '出错了，尝试重新连接...',
      name: 'playReconnect',
      desc: '',
      args: [],
    );
  }

  /// `线路{index}`
  String lineIndex(Object index) {
    return Intl.message('线路$index', name: 'lineIndex', desc: '', args: [index]);
  }

  /// `频道列表`
  String get tipChannelList {
    return Intl.message('频道列表', name: 'tipChannelList', desc: '', args: []);
  }

  /// `切换线路`
  String get tipChangeLine {
    return Intl.message('切换线路', name: 'tipChangeLine', desc: '', args: []);
  }

  /// `竖屏模式`
  String get portrait {
    return Intl.message('竖屏模式', name: 'portrait', desc: '', args: []);
  }

  /// `横屏模式`
  String get landscape {
    return Intl.message('横屏模式', name: 'landscape', desc: '', args: []);
  }

  /// `全屏切换`
  String get fullScreen {
    return Intl.message('全屏切换', name: 'fullScreen', desc: '', args: []);
  }

  /// `设置`
  String get settings {
    return Intl.message('设置', name: 'settings', desc: '', args: []);
  }

  /// `主页`
  String get homePage {
    return Intl.message('主页', name: 'homePage', desc: '', args: []);
  }

  /// `发布历史`
  String get releaseHistory {
    return Intl.message('发布历史', name: 'releaseHistory', desc: '', args: []);
  }

  /// `检查更新`
  String get checkUpdate {
    return Intl.message('检查更新', name: 'checkUpdate', desc: '', args: []);
  }

  /// `新版本v{version}`
  String newVersion(Object version) {
    return Intl.message(
      '新版本v$version',
      name: 'newVersion',
      desc: '',
      args: [version],
    );
  }

  /// `立即更新`
  String get update {
    return Intl.message('立即更新', name: 'update', desc: '', args: []);
  }

  /// `已是最新版本`
  String get latestVersion {
    return Intl.message('已是最新版本', name: 'latestVersion', desc: '', args: []);
  }

  /// `发现新版本`
  String get findNewVersion {
    return Intl.message('发现新版本', name: 'findNewVersion', desc: '', args: []);
  }

  /// `更新内容`
  String get updateContent {
    return Intl.message('更新内容', name: 'updateContent', desc: '', args: []);
  }

  /// `温馨提示`
  String get dialogTitle {
    return Intl.message('温馨提示', name: 'dialogTitle', desc: '', args: []);
  }

  /// `确定添加此数据源吗？`
  String get dataSourceContent {
    return Intl.message(
      '确定添加此数据源吗？',
      name: 'dataSourceContent',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get dialogCancel {
    return Intl.message('取消', name: 'dialogCancel', desc: '', args: []);
  }

  /// `确定`
  String get dialogConfirm {
    return Intl.message('确定', name: 'dialogConfirm', desc: '', args: []);
  }

  /// `IPTV订阅`
  String get subscribe {
    return Intl.message('IPTV订阅', name: 'subscribe', desc: '', args: []);
  }

  /// `创建时间`
  String get createTime {
    return Intl.message('创建时间', name: 'createTime', desc: '', args: []);
  }

  /// `确定删除此订阅吗？`
  String get dialogDeleteContent {
    return Intl.message(
      '确定删除此订阅吗？',
      name: 'dialogDeleteContent',
      desc: '',
      args: [],
    );
  }

  /// `删除`
  String get delete {
    return Intl.message('删除', name: 'delete', desc: '', args: []);
  }

  /// `设为默认`
  String get setDefault {
    return Intl.message('设为默认', name: 'setDefault', desc: '', args: []);
  }

  /// `使用中`
  String get inUse {
    return Intl.message('使用中', name: 'inUse', desc: '', args: []);
  }

  /// `参数错误`
  String get tvParseParma {
    return Intl.message('参数错误', name: 'tvParseParma', desc: '', args: []);
  }

  /// `推送成功`
  String get tvParseSuccess {
    return Intl.message('推送成功', name: 'tvParseSuccess', desc: '', args: []);
  }

  /// `请推送正确的链接`
  String get tvParsePushError {
    return Intl.message(
      '请推送正确的链接',
      name: 'tvParsePushError',
      desc: '',
      args: [],
    );
  }

  /// `扫码添加订阅源`
  String get tvScanTip {
    return Intl.message('扫码添加订阅源', name: 'tvScanTip', desc: '', args: []);
  }

  /// `推送地址：{address}`
  String pushAddress(Object address) {
    return Intl.message(
      '推送地址：$address',
      name: 'pushAddress',
      desc: '',
      args: [address],
    );
  }

  /// `注意：必须在同一WIFI网络环境下\n1、使用极简TV手机版扫码可快速完成数据添加和双向同步\n2、使用其他App扫码，在扫码结果页，输入新的订阅源，点击页面中的推送即可添加成功`
  String get tvPushContent {
    return Intl.message(
      '注意：必须在同一WIFI网络环境下\n1、使用极简TV手机版扫码可快速完成数据添加和双向同步\n2、使用其他App扫码，在扫码结果页，输入新的订阅源，点击页面中的推送即可添加成功',
      name: 'tvPushContent',
      desc: '',
      args: [],
    );
  }

  /// `复制订阅源后，回到此页面可自动添加订阅源`
  String get pasterContent {
    return Intl.message(
      '复制订阅源后，回到此页面可自动添加订阅源',
      name: 'pasterContent',
      desc: '',
      args: [],
    );
  }

  /// `添加订阅源`
  String get addDataSource {
    return Intl.message('添加订阅源', name: 'addDataSource', desc: '', args: []);
  }

  /// `请输入或粘贴.m3u或.txt格式的订阅源链接`
  String get addFiledHintText {
    return Intl.message(
      '请输入或粘贴.m3u或.txt格式的订阅源链接',
      name: 'addFiledHintText',
      desc: '',
      args: [],
    );
  }

  /// `已添加过此订阅源`
  String get addRepeat {
    return Intl.message('已添加过此订阅源', name: 'addRepeat', desc: '', args: []);
  }

  /// `请输入http/https链接`
  String get addNoHttpLink {
    return Intl.message(
      '请输入http/https链接',
      name: 'addNoHttpLink',
      desc: '',
      args: [],
    );
  }

  /// `连接超时`
  String get netTimeOut {
    return Intl.message('连接超时', name: 'netTimeOut', desc: '', args: []);
  }

  /// `请求超时`
  String get netSendTimeout {
    return Intl.message('请求超时', name: 'netSendTimeout', desc: '', args: []);
  }

  /// `响应超时`
  String get netReceiveTimeout {
    return Intl.message('响应超时', name: 'netReceiveTimeout', desc: '', args: []);
  }

  /// `响应异常{code}`
  String netBadResponse(Object code) {
    return Intl.message(
      '响应异常$code',
      name: 'netBadResponse',
      desc: '',
      args: [code],
    );
  }

  /// `请求取消`
  String get netCancel {
    return Intl.message('请求取消', name: 'netCancel', desc: '', args: []);
  }

  /// `解析数据源出错`
  String get parseError {
    return Intl.message('解析数据源出错', name: 'parseError', desc: '', args: []);
  }

  /// `默认`
  String get defaultText {
    return Intl.message('默认', name: 'defaultText', desc: '', args: []);
  }

  /// `获取默认数据源失败`
  String get getDefaultError {
    return Intl.message(
      '获取默认数据源失败',
      name: 'getDefaultError',
      desc: '',
      args: [],
    );
  }

  /// `【OK键】刷新`
  String get okRefresh {
    return Intl.message('【OK键】刷新', name: 'okRefresh', desc: '', args: []);
  }

  /// `刷新`
  String get refresh {
    return Intl.message('刷新', name: 'refresh', desc: '', args: []);
  }

  /// `暂无节目信息`
  String get noEPG {
    return Intl.message('暂无节目信息', name: 'noEPG', desc: '', args: []);
  }

  /// `文件不存在`
  String get noFile {
    return Intl.message('文件不存在', name: 'noFile', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
