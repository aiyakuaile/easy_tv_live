import 'package:flutter/material.dart';
import 'package:flutter_spinkit/src/spinning_lines.dart';
import 'package:responsive_builder/responsive_builder.dart';

class VideoHoldBg extends StatelessWidget {
  final String? toastString;
  const VideoHoldBg({Key? key, required this.toastString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30, bottom: 30),
        decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/video_bg.png'))),
        child: OrientationLayoutBuilder(
          portrait: (context) {
            return Column(
              children: [
                const SpinKitSpinningLines(color: Colors.white, size: 40),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(toastString ?? '正在加载', style: const TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            );
          },
          landscape: (context) {
            return Column(
              children: [
                const SpinKitSpinningLines(color: Colors.white, size: 40),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(toastString ?? '正在加载', style: const TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            );
          },
        ));
  }
}
