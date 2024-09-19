import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../util/env_util.dart';

class EmptyPage extends StatelessWidget {
  final GestureTapCallback onRefresh;
  final GestureTapCallback? onEnterSetting;
  const EmptyPage({super.key, required this.onRefresh, this.onEnterSetting});

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
          ),
          if (!EnvUtil.isMobile)
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextButton(
                onPressed: onEnterSetting,
                child: const Text('       切换源       ', style: TextStyle(color: Colors.white)),
              ),
            ),
        ],
      ),
    );
  }
}
