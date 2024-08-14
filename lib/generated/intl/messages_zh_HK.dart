// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_HK locale. All the
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
  String get localeName => 'zh_HK';

  static String m0(index) => "線路${index}";

  static String m1(line, channel) => "線路${line}播放: ${channel}";

  static String m2(code) => "響應異常${code}";

  static String m3(version) => "新版本v${version}";

  static String m4(address) => "推送地址：${address}";

  static String m5(line) => "切換線路${line} ...";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDataSource": MessageLookupByLibrary.simpleMessage("添加訂閱源"),
        "addFiledHintText":
            MessageLookupByLibrary.simpleMessage("請輸入或粘貼.m3u或.txt格式的訂閱源鏈接"),
        "addNoHttpLink":
            MessageLookupByLibrary.simpleMessage("請輸入http/https鏈接"),
        "addRepeat": MessageLookupByLibrary.simpleMessage("已添加過此訂閱源"),
        "appName": MessageLookupByLibrary.simpleMessage("極簡TV"),
        "checkUpdate": MessageLookupByLibrary.simpleMessage("檢查更新"),
        "createTime": MessageLookupByLibrary.simpleMessage("創建時間"),
        "dataSourceContent": MessageLookupByLibrary.simpleMessage("確定添加此數據源嗎？"),
        "delete": MessageLookupByLibrary.simpleMessage("刪除"),
        "dialogCancel": MessageLookupByLibrary.simpleMessage("取消"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("確定"),
        "dialogDeleteContent":
            MessageLookupByLibrary.simpleMessage("確定刪除此訂閱嗎？"),
        "dialogTitle": MessageLookupByLibrary.simpleMessage("溫馨提示"),
        "findNewVersion": MessageLookupByLibrary.simpleMessage("發現新版本"),
        "fullScreen": MessageLookupByLibrary.simpleMessage("全螢幕切換"),
        "getDefaultError": MessageLookupByLibrary.simpleMessage("獲取默認數據源失敗"),
        "homePage": MessageLookupByLibrary.simpleMessage("主頁"),
        "inUse": MessageLookupByLibrary.simpleMessage("使用中"),
        "landscape": MessageLookupByLibrary.simpleMessage("橫屏模式"),
        "latestVersion": MessageLookupByLibrary.simpleMessage("已是最新版本"),
        "lineIndex": m0,
        "lineToast": m1,
        "loading": MessageLookupByLibrary.simpleMessage("正在載入"),
        "netBadResponse": m2,
        "netCancel": MessageLookupByLibrary.simpleMessage("請求取消"),
        "netReceiveTimeout": MessageLookupByLibrary.simpleMessage("響應超時"),
        "netSendTimeout": MessageLookupByLibrary.simpleMessage("請求超時"),
        "netTimeOut": MessageLookupByLibrary.simpleMessage("連接超時"),
        "newVersion": m3,
        "okRefresh": MessageLookupByLibrary.simpleMessage("【OK鍵】刷新"),
        "parseError": MessageLookupByLibrary.simpleMessage("解析數據源出錯"),
        "pasterContent":
            MessageLookupByLibrary.simpleMessage("複製訂閱源後，回到此頁面可自動添加訂閱源"),
        "playError": MessageLookupByLibrary.simpleMessage("此視頻無法播放，請更換其它頻道"),
        "playReconnect": MessageLookupByLibrary.simpleMessage("出錯了，嘗試重新連接..."),
        "portrait": MessageLookupByLibrary.simpleMessage("豎屏模式"),
        "pushAddress": m4,
        "refresh": MessageLookupByLibrary.simpleMessage("刷新"),
        "releaseHistory": MessageLookupByLibrary.simpleMessage("發佈歷史"),
        "setDefault": MessageLookupByLibrary.simpleMessage("設為默認"),
        "settings": MessageLookupByLibrary.simpleMessage("設定"),
        "subscribe": MessageLookupByLibrary.simpleMessage("IPTV訂閱"),
        "switchLine": m5,
        "tipChangeLine": MessageLookupByLibrary.simpleMessage("切換線路"),
        "tipChannelList": MessageLookupByLibrary.simpleMessage("頻道列表"),
        "tvParseParma": MessageLookupByLibrary.simpleMessage("參數錯誤"),
        "tvParsePushError": MessageLookupByLibrary.simpleMessage("請推送正確的鏈接"),
        "tvParseSuccess": MessageLookupByLibrary.simpleMessage("推送成功"),
        "tvPushContent": MessageLookupByLibrary.simpleMessage(
            "在掃碼結果頁，輸入新的訂閱源，點擊頁面中的推送即可添加成功"),
        "tvScanTip": MessageLookupByLibrary.simpleMessage("掃碼添加訂閱源"),
        "update": MessageLookupByLibrary.simpleMessage("立即更新"),
        "updateContent": MessageLookupByLibrary.simpleMessage("更新內容")
      };
}
