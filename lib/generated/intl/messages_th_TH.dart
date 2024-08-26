// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a th_TH locale. All the
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
  String get localeName => 'th_TH';

  static String m0(index) => "สาย ${index}";

  static String m1(line, channel) => "สาย ${line} กำลังเล่น: ${channel}";

  static String m2(code) => "การตอบกลับผิดปกติ ${code}";

  static String m3(version) => "เวอร์ชันใหม่ v${version}";

  static String m4(address) => "ที่อยู่การส่ง: ${address}";

  static String m5(line) => "กำลังเปลี่ยนไปสาย ${line} ...";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDataSource":
            MessageLookupByLibrary.simpleMessage("เพิ่มแหล่งข้อมูลการสมัคร"),
        "addFiledHintText": MessageLookupByLibrary.simpleMessage(
            "กรุณาใส่หรือวางลิงก์แหล่งข้อมูลที่มีรูปแบบ .m3u หรือ .txt"),
        "addNoHttpLink":
            MessageLookupByLibrary.simpleMessage("กรุณาใส่ลิงก์ http/https"),
        "addRepeat": MessageLookupByLibrary.simpleMessage(
            "แหล่งข้อมูลการสมัครนี้ถูกเพิ่มแล้ว"),
        "appName": MessageLookupByLibrary.simpleMessage("EasyTV"),
        "checkUpdate": MessageLookupByLibrary.simpleMessage("ตรวจสอบการอัปเดต"),
        "createTime": MessageLookupByLibrary.simpleMessage("เวลาที่สร้าง"),
        "dataSourceContent": MessageLookupByLibrary.simpleMessage(
            "คุณแน่ใจหรือว่าต้องการเพิ่มแหล่งข้อมูลนี้?"),
        "delete": MessageLookupByLibrary.simpleMessage("ลบ"),
        "dialogCancel": MessageLookupByLibrary.simpleMessage("ยกเลิก"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("ยืนยัน"),
        "dialogDeleteContent": MessageLookupByLibrary.simpleMessage(
            "คุณแน่ใจหรือว่าต้องการลบการสมัครนี้?"),
        "dialogTitle":
            MessageLookupByLibrary.simpleMessage("คำเตือนที่เป็นมิตร"),
        "findNewVersion":
            MessageLookupByLibrary.simpleMessage("พบเวอร์ชันใหม่"),
        "fullScreen":
            MessageLookupByLibrary.simpleMessage("สลับไปยังโหมดเต็มจอ"),
        "getDefaultError": MessageLookupByLibrary.simpleMessage(
            "ไม่สามารถดึงแหล่งข้อมูลเริ่มต้นได้"),
        "homePage": MessageLookupByLibrary.simpleMessage("หน้าแรก"),
        "inUse": MessageLookupByLibrary.simpleMessage("กำลังใช้งาน"),
        "landscape": MessageLookupByLibrary.simpleMessage("โหมดแนวนอน"),
        "latestVersion":
            MessageLookupByLibrary.simpleMessage("คุณอยู่ในเวอร์ชันล่าสุดแล้ว"),
        "lineIndex": m0,
        "lineToast": m1,
        "loading": MessageLookupByLibrary.simpleMessage("กำลังโหลด"),
        "netBadResponse": m2,
        "netCancel": MessageLookupByLibrary.simpleMessage("คำขอยกเลิก"),
        "netReceiveTimeout":
            MessageLookupByLibrary.simpleMessage("การตอบกลับหมดเวลา"),
        "netSendTimeout": MessageLookupByLibrary.simpleMessage("คำขอหมดเวลา"),
        "netTimeOut":
            MessageLookupByLibrary.simpleMessage("การเชื่อมต่อหมดเวลา"),
        "newVersion": m3,
        "noEPG": MessageLookupByLibrary.simpleMessage(""),
        "okRefresh": MessageLookupByLibrary.simpleMessage("【ปุ่ม OK】 รีเฟรช"),
        "parseError": MessageLookupByLibrary.simpleMessage(
            "ข้อผิดพลาดในการวิเคราะห์แหล่งข้อมูล"),
        "pasterContent": MessageLookupByLibrary.simpleMessage(
            "หลังจากคัดลอกแหล่งข้อมูลการสมัครแล้ว ให้กลับมาที่หน้านี้เพื่อเพิ่มแหล่งข้อมูลการสมัครโดยอัตโนมัติ"),
        "playError": MessageLookupByLibrary.simpleMessage(
            "ไม่สามารถเล่นวิดีโอนี้ได้ กรุณาเปลี่ยนไปยังช่องอื่น"),
        "playReconnect": MessageLookupByLibrary.simpleMessage(
            "เกิดข้อผิดพลาด กำลังพยายามเชื่อมต่ออีกครั้ง..."),
        "portrait": MessageLookupByLibrary.simpleMessage("โหมดแนวตั้ง"),
        "pushAddress": m4,
        "refresh": MessageLookupByLibrary.simpleMessage("รีเฟรช"),
        "releaseHistory":
            MessageLookupByLibrary.simpleMessage("ประวัติการเผยแพร่"),
        "setDefault":
            MessageLookupByLibrary.simpleMessage("ตั้งเป็นค่าเริ่มต้น"),
        "settings": MessageLookupByLibrary.simpleMessage("การตั้งค่า"),
        "subscribe": MessageLookupByLibrary.simpleMessage("การสมัคร IPTV"),
        "switchLine": m5,
        "tipChangeLine": MessageLookupByLibrary.simpleMessage("เปลี่ยนสาย"),
        "tipChannelList": MessageLookupByLibrary.simpleMessage("รายการช่อง"),
        "tvParseParma":
            MessageLookupByLibrary.simpleMessage("ข้อผิดพลาดของพารามิเตอร์"),
        "tvParsePushError":
            MessageLookupByLibrary.simpleMessage("กรุณาส่งลิงก์ที่ถูกต้อง"),
        "tvParseSuccess": MessageLookupByLibrary.simpleMessage("การส่งสำเร็จ"),
        "tvPushContent": MessageLookupByLibrary.simpleMessage(
            "ในหน้าผลลัพธ์การสแกน ให้ป้อนแหล่งข้อมูลการสมัครใหม่ และคลิกปุ่มส่งเพื่อเพิ่มสำเร็จ"),
        "tvScanTip": MessageLookupByLibrary.simpleMessage(
            "สแกนเพื่อเพิ่มแหล่งข้อมูลการสมัคร"),
        "update": MessageLookupByLibrary.simpleMessage("อัปเดตทันที"),
        "updateContent":
            MessageLookupByLibrary.simpleMessage("เนื้อหาการอัปเดต")
      };
}
