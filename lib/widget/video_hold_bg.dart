import 'package:easy_tv_live/util/bing_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/src/spinning_lines.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../provider/theme_provider.dart';

class VideoHoldBg extends StatelessWidget {
  final String? toastString;

  const VideoHoldBg({Key? key, required this.toastString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (_, provider) => provider.isBingBg,
      builder: (BuildContext context, bool isBingBg, Widget? child) {
        if (isBingBg) {
          return FutureBuilder(
            future: BingUtil.getBingImgUrl(),
            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              late ImageProvider image;
              if (snapshot.hasData && snapshot.data != null) {
                image = NetworkImage(snapshot.data!);
              } else {
                image = const AssetImage('assets/images/video_bg.png');
              }
              return Container(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: image,
                  ),
                ),
                child: child,
              );
            },
          );
        }
        return Container(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/video_bg.png'),
            ),
          ),
          child: child,
        );
      },
      child: Column(
        children: [
          const SpinKitSpinningLines(color: Colors.white, size: 40),
          const Spacer(),
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(toastString ?? S.current.loading, style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
