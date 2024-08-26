// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko_KR locale. All the
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
  String get localeName => 'ko_KR';

  static String m0(index) => "라인 ${index}";

  static String m1(line, channel) => "라인 ${line} 재생 중: ${channel}";

  static String m2(code) => "비정상 응답 ${code}";

  static String m3(version) => "새 버전 v${version}";

  static String m4(address) => "푸시 주소: ${address}";

  static String m5(line) => "라인 ${line}으로 전환 중...";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDataSource": MessageLookupByLibrary.simpleMessage("구독 소스 추가"),
        "addFiledHintText": MessageLookupByLibrary.simpleMessage(
            ".m3u 또는 .txt 형식의 구독 링크를 입력하거나 붙여넣어 주세요."),
        "addNoHttpLink":
            MessageLookupByLibrary.simpleMessage("http/https 링크를 입력해 주세요"),
        "addRepeat":
            MessageLookupByLibrary.simpleMessage("이 구독 소스는 이미 추가되었습니다"),
        "appName": MessageLookupByLibrary.simpleMessage("EasyTV"),
        "checkUpdate": MessageLookupByLibrary.simpleMessage("업데이트 확인"),
        "createTime": MessageLookupByLibrary.simpleMessage("생성 시간"),
        "dataSourceContent":
            MessageLookupByLibrary.simpleMessage("이 데이터 소스를 추가하시겠습니까?"),
        "delete": MessageLookupByLibrary.simpleMessage("삭제"),
        "dialogCancel": MessageLookupByLibrary.simpleMessage("취소"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("확인"),
        "dialogDeleteContent":
            MessageLookupByLibrary.simpleMessage("이 구독을 삭제하시겠습니까?"),
        "dialogTitle": MessageLookupByLibrary.simpleMessage("친절한 알림"),
        "findNewVersion": MessageLookupByLibrary.simpleMessage("새 버전이 발견되었습니다"),
        "fullScreen": MessageLookupByLibrary.simpleMessage("전체 화면 전환"),
        "getDefaultError":
            MessageLookupByLibrary.simpleMessage("기본 데이터 소스 가져오기 실패"),
        "homePage": MessageLookupByLibrary.simpleMessage("홈페이지"),
        "inUse": MessageLookupByLibrary.simpleMessage("사용 중"),
        "landscape": MessageLookupByLibrary.simpleMessage("가로 모드"),
        "latestVersion": MessageLookupByLibrary.simpleMessage("최신 버전입니다"),
        "lineIndex": m0,
        "lineToast": m1,
        "loading": MessageLookupByLibrary.simpleMessage("로딩 중"),
        "netBadResponse": m2,
        "netCancel": MessageLookupByLibrary.simpleMessage("요청 취소"),
        "netReceiveTimeout": MessageLookupByLibrary.simpleMessage("응답 시간 초과"),
        "netSendTimeout": MessageLookupByLibrary.simpleMessage("요청 시간 초과"),
        "netTimeOut": MessageLookupByLibrary.simpleMessage("연결 시간 초과"),
        "newVersion": m3,
        "noEPG": MessageLookupByLibrary.simpleMessage(""),
        "okRefresh": MessageLookupByLibrary.simpleMessage("【OK 버튼】 새로 고침"),
        "parseError": MessageLookupByLibrary.simpleMessage("데이터 소스 분석 오류"),
        "pasterContent": MessageLookupByLibrary.simpleMessage(
            "구독 소스를 복사한 후 이 페이지로 돌아가 자동으로 구독 소스를 추가합니다."),
        "playError": MessageLookupByLibrary.simpleMessage(
            "이 비디오는 재생할 수 없습니다. 다른 채널로 변경해 주세요."),
        "playReconnect":
            MessageLookupByLibrary.simpleMessage("오류가 발생했습니다. 재연결을 시도합니다..."),
        "portrait": MessageLookupByLibrary.simpleMessage("세로 모드"),
        "pushAddress": m4,
        "refresh": MessageLookupByLibrary.simpleMessage("새로 고침"),
        "releaseHistory": MessageLookupByLibrary.simpleMessage("릴리스 역사"),
        "setDefault": MessageLookupByLibrary.simpleMessage("기본값으로 설정"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "subscribe": MessageLookupByLibrary.simpleMessage("IPTV 구독"),
        "switchLine": m5,
        "tipChangeLine": MessageLookupByLibrary.simpleMessage("라인 전환"),
        "tipChannelList": MessageLookupByLibrary.simpleMessage("채널 목록"),
        "tvParseParma": MessageLookupByLibrary.simpleMessage("파라미터 오류"),
        "tvParsePushError":
            MessageLookupByLibrary.simpleMessage("올바른 링크를 푸시해 주세요"),
        "tvParseSuccess": MessageLookupByLibrary.simpleMessage("푸시 성공"),
        "tvPushContent": MessageLookupByLibrary.simpleMessage(
            "스캔 결과 페이지에서 새로운 구독 소스를 입력하고 페이지의 푸시 버튼을 클릭하여 성공적으로 추가합니다."),
        "tvScanTip": MessageLookupByLibrary.simpleMessage("스캔하여 구독 소스를 추가"),
        "update": MessageLookupByLibrary.simpleMessage("지금 업데이트"),
        "updateContent": MessageLookupByLibrary.simpleMessage("업데이트 내용")
      };
}
