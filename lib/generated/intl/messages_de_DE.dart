// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de_DE locale. All the
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
  String get localeName => 'de_DE';

  static String m0(index) => "Linie ${index}";

  static String m1(line, channel) => "Linie ${line} spielt: ${channel}";

  static String m2(code) => "Anormale Antwort ${code}";

  static String m3(version) => "Neue Version v${version}";

  static String m4(address) => "Push-Adresse: ${address}";

  static String m5(line) => "Wechsel zu Linie ${line} ...";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDataSource":
            MessageLookupByLibrary.simpleMessage("Abonnementquelle hinzufügen"),
        "addFiledHintText": MessageLookupByLibrary.simpleMessage(
            "Bitte geben Sie den Link zur Abonnementquelle im .m3u- oder .txt-Format ein oder fügen Sie ihn ein"),
        "addNoHttpLink": MessageLookupByLibrary.simpleMessage(
            "Bitte geben Sie einen http/https-Link ein"),
        "addRepeat": MessageLookupByLibrary.simpleMessage(
            "Diese Abonnementquelle wurde bereits hinzugefügt"),
        "appName": MessageLookupByLibrary.simpleMessage("EasyTV"),
        "checkUpdate":
            MessageLookupByLibrary.simpleMessage("Auf Updates prüfen"),
        "createTime": MessageLookupByLibrary.simpleMessage("Erstellungszeit"),
        "dataSourceContent": MessageLookupByLibrary.simpleMessage(
            "Sind Sie sicher, dass Sie diese Datenquelle hinzufügen möchten?"),
        "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "dialogCancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("Bestätigen"),
        "dialogDeleteContent": MessageLookupByLibrary.simpleMessage(
            "Sind Sie sicher, dass Sie dieses Abonnement löschen möchten?"),
        "dialogTitle":
            MessageLookupByLibrary.simpleMessage("Freundliche Erinnerung"),
        "findNewVersion":
            MessageLookupByLibrary.simpleMessage("Neue Version gefunden"),
        "fullScreen":
            MessageLookupByLibrary.simpleMessage("Vollbild umschalten"),
        "getDefaultError": MessageLookupByLibrary.simpleMessage(
            "Fehler beim Abrufen der Standarddatenquelle"),
        "homePage": MessageLookupByLibrary.simpleMessage("Startseite"),
        "inUse": MessageLookupByLibrary.simpleMessage("In Verwendung"),
        "landscape": MessageLookupByLibrary.simpleMessage("Querformat"),
        "latestVersion": MessageLookupByLibrary.simpleMessage(
            "Sie sind auf der neuesten Version"),
        "lineIndex": m0,
        "lineToast": m1,
        "loading": MessageLookupByLibrary.simpleMessage("Wird geladen"),
        "netBadResponse": m2,
        "netCancel":
            MessageLookupByLibrary.simpleMessage("Anfrage abgebrochen"),
        "netReceiveTimeout":
            MessageLookupByLibrary.simpleMessage("Antwortzeitüberschreitung"),
        "netSendTimeout":
            MessageLookupByLibrary.simpleMessage("Anfragezeitüberschreitung"),
        "netTimeOut":
            MessageLookupByLibrary.simpleMessage("Verbindungstimeout"),
        "newVersion": m3,
        "okRefresh":
            MessageLookupByLibrary.simpleMessage("【OK-Taste】 Aktualisieren"),
        "parseError": MessageLookupByLibrary.simpleMessage(
            "Fehler beim Analysieren der Datenquelle"),
        "pasterContent": MessageLookupByLibrary.simpleMessage(
            "Nachdem Sie die Abonnementquelle kopiert haben, kehren Sie zu dieser Seite zurück, um die Abonnementquelle automatisch hinzuzufügen."),
        "playError": MessageLookupByLibrary.simpleMessage(
            "Dieses Video kann nicht abgespielt werden, bitte wechseln Sie zu einem anderen Kanal"),
        "playReconnect": MessageLookupByLibrary.simpleMessage(
            "Ein Fehler ist aufgetreten, versuche erneut zu verbinden..."),
        "portrait": MessageLookupByLibrary.simpleMessage("Hochformat"),
        "pushAddress": m4,
        "refresh": MessageLookupByLibrary.simpleMessage("Aktualisieren"),
        "releaseHistory": MessageLookupByLibrary.simpleMessage(
            "Verlauf der Veröffentlichungen"),
        "setDefault":
            MessageLookupByLibrary.simpleMessage("Als Standard festlegen"),
        "settings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "subscribe": MessageLookupByLibrary.simpleMessage("IPTV-Abonnement"),
        "switchLine": m5,
        "tipChangeLine": MessageLookupByLibrary.simpleMessage("Linie wechseln"),
        "tipChannelList":
            MessageLookupByLibrary.simpleMessage("Kanalübersicht"),
        "tvParseParma": MessageLookupByLibrary.simpleMessage("Parameterfehler"),
        "tvParsePushError": MessageLookupByLibrary.simpleMessage(
            "Bitte den richtigen Link pushen"),
        "tvParseSuccess":
            MessageLookupByLibrary.simpleMessage("Erfolgreich gepusht"),
        "tvPushContent": MessageLookupByLibrary.simpleMessage(
            "Geben Sie auf der Scan-Ergebnisseite die neue Abonnementquelle ein und klicken Sie auf die Schaltfläche Push, um sie erfolgreich hinzuzufügen."),
        "tvScanTip": MessageLookupByLibrary.simpleMessage(
            "Scannen, um die Abonnementquelle hinzuzufügen"),
        "update": MessageLookupByLibrary.simpleMessage("Jetzt aktualisieren"),
        "updateContent":
            MessageLookupByLibrary.simpleMessage("Inhalt der Aktualisierung")
      };
}
