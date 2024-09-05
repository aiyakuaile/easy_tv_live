import 'package:flutter/material.dart';

import '../util/date_util.dart';

class DatePositionWidget extends StatelessWidget {
  const DatePositionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: IgnorePointer(
        child: Card(
          color: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateUtil.formatDate(DateTime.now(), format: 'HH:mm'),
                  style: const TextStyle(fontSize: 50),
                ),
                Text(DateUtil.formatDate(DateTime.now(), format: 'yyyy/MM/dd'), style: const TextStyle(fontSize: 20)),
                Text(DateUtil.getWeekday(DateTime.now(), languageCode: 'zh'), style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
