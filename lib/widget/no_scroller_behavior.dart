import 'package:flutter/widgets.dart';

class NoScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
