import 'package:easy_tv_live/util/env_util.dart';
import 'package:easy_tv_live/util/http_util.dart';
import 'package:flutter/material.dart';

class TvAppreciatePage extends StatefulWidget {
  const TvAppreciatePage({super.key});

  @override
  State<TvAppreciatePage> createState() => _TvAppreciatePageState();
}

class _TvAppreciatePageState extends State<TvAppreciatePage> {
  String rewardText = '';

  final _scrollController = ScrollController();

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2022),
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        title: const Text('使用微信扫一扫，为我打赏！'),
        backgroundColor: const Color(0xFF1E2022),
      ),
      body: Row(
        children: [
          Image.asset('assets/images/appreciate.png'),
          Expanded(
            child: Container(
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  const Text(
                    '💝 赞赏榜 💝',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Text(
                        rewardText,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: IconButton(
                              onPressed: () {
                                _scrollController.animateTo(_scrollController.offset - 100,
                                    duration: const Duration(milliseconds: 300), curve: Curves.linear);
                              },
                              icon: const Icon(Icons.keyboard_arrow_up))),
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              _scrollController.animateTo(_scrollController.offset + 100,
                                  duration: const Duration(milliseconds: 300), curve: Curves.linear);
                            },
                            icon: const Icon(Icons.keyboard_arrow_down)),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
