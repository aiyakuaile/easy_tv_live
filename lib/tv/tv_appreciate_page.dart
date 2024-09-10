import 'package:flutter/material.dart';

class TvAppreciatePage extends StatelessWidget {
  const TvAppreciatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1E2022),
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          title: const Text('使用微信扫一扫，为我打赏！'),
          backgroundColor: const Color(0xFF1E2022),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Image.asset('assets/images/appreciate.png'),
        ));
  }
}
