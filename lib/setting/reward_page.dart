import 'package:flutter/material.dart';

import '../util/env_util.dart';
import '../util/http_util.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  String rewardText = '';

  @override
  void initState() {
    _loadReward();
    super.initState();
  }

  _loadReward() async {
    final res = await HttpUtil().getRequest(EnvUtil.rewardLink(), isShowLoading: false);
    if (mounted && res != null && res != '') {
      setState(() {
        rewardText = res.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('赞赏榜'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '使用微信扫一扫下方赞赏码，支持本软件！',
            ),
            const Divider(),
            Image.asset('assets/images/appreciate.png'),
            const SizedBox(height: 20),
            const Text(
              '🌈特别鸣谢以下老铁！',
              style: TextStyle(fontSize: 17),
            ),
            const Text(
              '若有遗漏请前往Github联系我补充！',
              style: TextStyle(fontSize: 10),
            ),
            const Divider(),
            Text(
              rewardText,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 2.0),
            )
          ],
        ),
      ),
    );
  }
}
