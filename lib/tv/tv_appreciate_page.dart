import 'package:easy_tv_live/util/env_util.dart';
import 'package:easy_tv_live/util/http_util.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class TvAppreciatePage extends StatefulWidget {
  const TvAppreciatePage({super.key});

  @override
  State<TvAppreciatePage> createState() => _TvAppreciatePageState();
}

class _TvAppreciatePageState extends State<TvAppreciatePage> {
  String rewardText = '';
  final _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  Timer? _resumeScrollTimer;
  bool _isUserScrolling = false;

  @override
  void initState() {
    _loadReward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _startAutoScroll();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _resumeScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  _loadReward() async {
    final res =
        await HttpUtil().getRequest(EnvUtil.rewardLink(), isShowLoading: false);
    if (mounted && res != null && res != '') {
      setState(() {
        rewardText = res.toString();
      });
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    const scrollDuration = Duration(milliseconds: 50);
    const scrollAmount = 1.0;

    _autoScrollTimer = Timer.periodic(scrollDuration, (timer) {
      if (!mounted || rewardText.isEmpty || _isUserScrolling) return;

      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;

        if (currentScroll >= maxScroll) {
          _autoScrollTimer?.cancel();
          _scrollController.jumpTo(0);
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted && !_isUserScrolling) {
              _startAutoScroll();
            }
          });
        } else {
          _scrollController.jumpTo(currentScroll + scrollAmount);
        }
      }
    });
  }

  void _handleManualScroll() {
    _isUserScrolling = true;
    _autoScrollTimer?.cancel();

    // 取消之前的恢复定时器（如果存在）
    _resumeScrollTimer?.cancel();

    // 设置新的恢复定时器
    _resumeScrollTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isUserScrolling = false;
          _startAutoScroll();
        });
      }
    });
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
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            _handleManualScroll();
                            _scrollController.animateTo(
                              _scrollController.offset - 100,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                            );
                          },
                          icon: const Icon(Icons.keyboard_arrow_up),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            _handleManualScroll();
                            _scrollController.animateTo(
                              _scrollController.offset + 100,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                            );
                          },
                          icon: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ),
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
