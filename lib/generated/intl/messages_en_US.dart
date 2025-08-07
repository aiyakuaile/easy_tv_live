// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
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
  String get localeName => 'en_US';

  static String m0(index) => "Line ${index}";

  static String m1(line, channel) => "Line ${line} playing: ${channel}";

  static String m2(code) => "Abnormal response ${code}";

  static String m3(version) => "New Version v${version}";

  static String m4(channel) =>
      "${channel}: cannot be played, please switch to another channel";

  static String m5(address) => "Push Address: ${address}";

  static String m6(line) => "Switching to line ${line} ...";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addDataSource": MessageLookupByLibrary.simpleMessage(
      "Add Subscription Source",
    ),
    "addFiledHintText": MessageLookupByLibrary.simpleMessage(
      "Please enter or paste the .m3u or .txt format subscription link",
    ),
    "addNoHttpLink": MessageLookupByLibrary.simpleMessage(
      "Please enter an http/https link",
    ),
    "addRepeat": MessageLookupByLibrary.simpleMessage(
      "This subscription source has been added",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("EasyTV"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Check for Updates"),
    "createTime": MessageLookupByLibrary.simpleMessage("Creation Time"),
    "dataSourceContent": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to add this data source?",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("Default"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "dialogCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "dialogConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "dialogDeleteContent": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this subscription?",
    ),
    "dialogTitle": MessageLookupByLibrary.simpleMessage("Friendly Reminder"),
    "findNewVersion": MessageLookupByLibrary.simpleMessage("New version found"),
    "fullScreen": MessageLookupByLibrary.simpleMessage("Full Screen Toggle"),
    "getDefaultError": MessageLookupByLibrary.simpleMessage(
      "Failed to get the default data source",
    ),
    "homePage": MessageLookupByLibrary.simpleMessage("Home Page"),
    "inUse": MessageLookupByLibrary.simpleMessage("In Use"),
    "landscape": MessageLookupByLibrary.simpleMessage("Landscape Mode"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "You are on the latest version",
    ),
    "lineIndex": m0,
    "lineToast": m1,
    "loading": MessageLookupByLibrary.simpleMessage("Loading"),
    "netBadResponse": m2,
    "netCancel": MessageLookupByLibrary.simpleMessage("Request Cancelled"),
    "netReceiveTimeout": MessageLookupByLibrary.simpleMessage(
      "Response timed out",
    ),
    "netSendTimeout": MessageLookupByLibrary.simpleMessage("Request timed out"),
    "netTimeOut": MessageLookupByLibrary.simpleMessage("Connection timed out"),
    "newVersion": m3,
    "noEPG": MessageLookupByLibrary.simpleMessage("NO EPG DATA"),
    "noFile": MessageLookupByLibrary.simpleMessage("File Does Not Exist"),
    "okRefresh": MessageLookupByLibrary.simpleMessage("【OK key】 Refresh"),
    "parseError": MessageLookupByLibrary.simpleMessage(
      "Error parsing data source",
    ),
    "pasterContent": MessageLookupByLibrary.simpleMessage(
      "After copying the subscription source, return to this page to automatically add the subscription source",
    ),
    "playError": m4,
    "playReconnect": MessageLookupByLibrary.simpleMessage(
      "An error occurred, trying to reconnect...",
    ),
    "portrait": MessageLookupByLibrary.simpleMessage("Portrait Mode"),
    "pushAddress": m5,
    "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
    "releaseHistory": MessageLookupByLibrary.simpleMessage("Release History"),
    "setDefault": MessageLookupByLibrary.simpleMessage("Set as Default"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "subscribe": MessageLookupByLibrary.simpleMessage("IPTV Subscription"),
    "switchLine": m6,
    "tipChangeLine": MessageLookupByLibrary.simpleMessage("Switch Line"),
    "tipChannelList": MessageLookupByLibrary.simpleMessage("Channel List"),
    "tvParseParma": MessageLookupByLibrary.simpleMessage("Parameter Error"),
    "tvParsePushError": MessageLookupByLibrary.simpleMessage(
      "Please push the correct link",
    ),
    "tvParseSuccess": MessageLookupByLibrary.simpleMessage("Push Successful"),
    "tvPushContent": MessageLookupByLibrary.simpleMessage(
      "On the scan result page, enter the new subscription source and click the push button to add successfully",
    ),
    "tvScanTip": MessageLookupByLibrary.simpleMessage(
      "Scan to add subscription source",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Update Now"),
    "updateContent": MessageLookupByLibrary.simpleMessage("Update Content"),
  };
}
