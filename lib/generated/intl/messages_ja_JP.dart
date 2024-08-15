// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja_JP locale. All the
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
  String get localeName => 'ja_JP';

  static String m0(index) => "ライン${index}";

  static String m1(line, channel) => "ライン${line}再生中: ${channel}";

  static String m2(code) => "異常な応答${code}";

  static String m3(version) => "新しいバージョンv${version}";

  static String m4(address) => "プッシュアドレス: ${address}";

  static String m5(line) => "ライン${line}に切り替え中...";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDataSource": MessageLookupByLibrary.simpleMessage("IPTV追加"),
        "addFiledHintText": MessageLookupByLibrary.simpleMessage(
            ".m3uまたは.txt形式のサブスクリプションリンクを入力または貼り付けてください。"),
        "addNoHttpLink":
            MessageLookupByLibrary.simpleMessage("http/httpsリンクを入力してください"),
        "addRepeat":
            MessageLookupByLibrary.simpleMessage("このサブスクリプションソースは既に追加されています"),
        "appName": MessageLookupByLibrary.simpleMessage("EasyTV"),
        "checkUpdate": MessageLookupByLibrary.simpleMessage("アップデートを確認"),
        "createTime": MessageLookupByLibrary.simpleMessage("作成時間"),
        "dataSourceContent":
            MessageLookupByLibrary.simpleMessage("このデータソースを追加してもよろしいですか？"),
        "delete": MessageLookupByLibrary.simpleMessage("削除"),
        "dialogCancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("確認"),
        "dialogDeleteContent":
            MessageLookupByLibrary.simpleMessage("このサブスクリプションを削除してもよろしいですか？"),
        "dialogTitle": MessageLookupByLibrary.simpleMessage("温かいお知らせ"),
        "findNewVersion":
            MessageLookupByLibrary.simpleMessage("新しいバージョンが見つかりました"),
        "fullScreen": MessageLookupByLibrary.simpleMessage("フルスクリーン切替"),
        "getDefaultError":
            MessageLookupByLibrary.simpleMessage("デフォルトデータソースの取得に失敗しました"),
        "homePage": MessageLookupByLibrary.simpleMessage("ホームページ"),
        "inUse": MessageLookupByLibrary.simpleMessage("使用中"),
        "landscape": MessageLookupByLibrary.simpleMessage("横画面モード"),
        "latestVersion": MessageLookupByLibrary.simpleMessage("最新バージョンです"),
        "lineIndex": m0,
        "lineToast": m1,
        "loading": MessageLookupByLibrary.simpleMessage("読み込み中"),
        "netBadResponse": m2,
        "netCancel": MessageLookupByLibrary.simpleMessage("リクエストキャンセル"),
        "netReceiveTimeout": MessageLookupByLibrary.simpleMessage("応答タイムアウト"),
        "netSendTimeout": MessageLookupByLibrary.simpleMessage("リクエストタイムアウト"),
        "netTimeOut": MessageLookupByLibrary.simpleMessage("接続タイムアウト"),
        "newVersion": m3,
        "okRefresh": MessageLookupByLibrary.simpleMessage("【OKキー】リフレッシュ"),
        "parseError": MessageLookupByLibrary.simpleMessage("データソースの解析エラー"),
        "pasterContent": MessageLookupByLibrary.simpleMessage(
            "サブスクリプションソースをコピーした後、このページに戻って自動的にサブスクリプションソースを追加します。"),
        "playError": MessageLookupByLibrary.simpleMessage(
            "この動画は再生できません。他のチャンネルに切り替えてください。"),
        "playReconnect":
            MessageLookupByLibrary.simpleMessage("エラーが発生しました。再接続を試みています..."),
        "portrait": MessageLookupByLibrary.simpleMessage("縦画面モード"),
        "pushAddress": m4,
        "refresh": MessageLookupByLibrary.simpleMessage("リフレッシュ"),
        "releaseHistory": MessageLookupByLibrary.simpleMessage("リリース履歴"),
        "setDefault": MessageLookupByLibrary.simpleMessage("デフォルトに設定"),
        "settings": MessageLookupByLibrary.simpleMessage("設定"),
        "subscribe": MessageLookupByLibrary.simpleMessage("订阅"),
        "switchLine": m5,
        "tipChangeLine": MessageLookupByLibrary.simpleMessage("ラインを切り替える"),
        "tipChannelList": MessageLookupByLibrary.simpleMessage("チャンネルリスト"),
        "tvParseParma": MessageLookupByLibrary.simpleMessage("パラメータエラー"),
        "tvParsePushError":
            MessageLookupByLibrary.simpleMessage("正しいリンクをプッシュしてください"),
        "tvParseSuccess": MessageLookupByLibrary.simpleMessage("プッシュ成功"),
        "tvPushContent": MessageLookupByLibrary.simpleMessage(
            "スキャン結果ページで新しいサブスクリプションソースを入力し、ページのプッシュをクリックして正常に追加します。"),
        "tvScanTip":
            MessageLookupByLibrary.simpleMessage("スキャンしてサブスクリプションソースを追加"),
        "update": MessageLookupByLibrary.simpleMessage("今すぐ更新"),
        "updateContent": MessageLookupByLibrary.simpleMessage("更新内容")
      };
}
