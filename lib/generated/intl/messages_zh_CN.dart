// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static String m0(index) => "线路${index}";

  static String m1(line, channel) => "线路${line}播放: ${channel}";

  static String m2(code) => "响应异常${code}";

  static String m3(version) => "新版本v${version}";

  static String m4(channel) => "${channel}：无法播放，请更换其它频道";

  static String m5(address) => "推送地址：${address}";

  static String m6(line) => "切换线路${line} ...";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addDataSource": MessageLookupByLibrary.simpleMessage("添加订阅源"),
    "addFiledHintText": MessageLookupByLibrary.simpleMessage(
      "请输入或粘贴.m3u或.txt格式的订阅源链接",
    ),
    "addNoHttpLink": MessageLookupByLibrary.simpleMessage("请输入http/https链接"),
    "addRepeat": MessageLookupByLibrary.simpleMessage("已添加过此订阅源"),
    "appName": MessageLookupByLibrary.simpleMessage("极简TV"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("检查更新"),
    "createTime": MessageLookupByLibrary.simpleMessage("创建时间"),
    "dataSourceContent": MessageLookupByLibrary.simpleMessage("确定添加此数据源吗？"),
    "defaultText": MessageLookupByLibrary.simpleMessage("默认"),
    "delete": MessageLookupByLibrary.simpleMessage("删除"),
    "dialogCancel": MessageLookupByLibrary.simpleMessage("取消"),
    "dialogConfirm": MessageLookupByLibrary.simpleMessage("确定"),
    "dialogDeleteContent": MessageLookupByLibrary.simpleMessage("确定删除此订阅吗？"),
    "dialogTitle": MessageLookupByLibrary.simpleMessage("温馨提示"),
    "findNewVersion": MessageLookupByLibrary.simpleMessage("发现新版本"),
    "fullScreen": MessageLookupByLibrary.simpleMessage("全屏切换"),
    "getDefaultError": MessageLookupByLibrary.simpleMessage("获取默认数据源失败"),
    "homePage": MessageLookupByLibrary.simpleMessage("主页"),
    "inUse": MessageLookupByLibrary.simpleMessage("使用中"),
    "landscape": MessageLookupByLibrary.simpleMessage("横屏模式"),
    "latestVersion": MessageLookupByLibrary.simpleMessage("已是最新版本"),
    "lineIndex": m0,
    "lineToast": m1,
    "loading": MessageLookupByLibrary.simpleMessage("正在加载"),
    "netBadResponse": m2,
    "netCancel": MessageLookupByLibrary.simpleMessage("请求取消"),
    "netReceiveTimeout": MessageLookupByLibrary.simpleMessage("响应超时"),
    "netSendTimeout": MessageLookupByLibrary.simpleMessage("请求超时"),
    "netTimeOut": MessageLookupByLibrary.simpleMessage("连接超时"),
    "newVersion": m3,
    "noEPG": MessageLookupByLibrary.simpleMessage("暂无节目信息"),
    "noFile": MessageLookupByLibrary.simpleMessage("文件不存在"),
    "okRefresh": MessageLookupByLibrary.simpleMessage("【OK键】刷新"),
    "parseError": MessageLookupByLibrary.simpleMessage("解析数据源出错"),
    "pasterContent": MessageLookupByLibrary.simpleMessage(
      "复制订阅源后，回到此页面可自动添加订阅源",
    ),
    "playError": m4,
    "playReconnect": MessageLookupByLibrary.simpleMessage("出错了，尝试重新连接..."),
    "portrait": MessageLookupByLibrary.simpleMessage("竖屏模式"),
    "pushAddress": m5,
    "refresh": MessageLookupByLibrary.simpleMessage("刷新"),
    "releaseHistory": MessageLookupByLibrary.simpleMessage("发布历史"),
    "setDefault": MessageLookupByLibrary.simpleMessage("设为默认"),
    "settings": MessageLookupByLibrary.simpleMessage("设置"),
    "subscribe": MessageLookupByLibrary.simpleMessage("IPTV订阅"),
    "switchLine": m6,
    "tipChangeLine": MessageLookupByLibrary.simpleMessage("切换线路"),
    "tipChannelList": MessageLookupByLibrary.simpleMessage("频道列表"),
    "tvParseParma": MessageLookupByLibrary.simpleMessage("参数错误"),
    "tvParsePushError": MessageLookupByLibrary.simpleMessage("请推送正确的链接"),
    "tvParseSuccess": MessageLookupByLibrary.simpleMessage("推送成功"),
    "tvPushContent": MessageLookupByLibrary.simpleMessage(
      "注意：必须在同一WIFI网络环境下\n1、使用极简TV手机版扫码可快速完成数据添加和双向同步\n2、使用其他App扫码，在扫码结果页，输入新的订阅源，点击页面中的推送即可添加成功",
    ),
    "tvScanTip": MessageLookupByLibrary.simpleMessage("扫码添加订阅源"),
    "update": MessageLookupByLibrary.simpleMessage("立即更新"),
    "updateContent": MessageLookupByLibrary.simpleMessage("更新内容"),
  };
}
