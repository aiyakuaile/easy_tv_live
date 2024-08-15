import 'package:easy_tv_live/util/env_util.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class EmptyPage extends StatelessWidget {
  final GestureTapCallback onRefresh;
  const EmptyPage({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '⚠️',
            style: TextStyle(fontSize: 50),
          ),
          const Text(
            '╮(╯▽╰)╭',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: onRefresh,
            child: Text('      ${EnvUtil.isTV() ? S.current.okRefresh : S.current.refresh}      ', style: const TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
