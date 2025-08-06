// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    String ipLink = 'http://192.168.1.127:8848';
    final host = Uri.parse(ipLink).host;
    debugPrint('host::::$host');
  });
  test('test path', (){
    final path = 'C:/Users/Administrator/Desktop/test/test.txt';
    debugPrint('path::::${p.basename(path)}');
  });
}
