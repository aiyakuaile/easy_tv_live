import 'package:easy_tv_live/easy_web_page.dart';
import 'package:easy_tv_live/web_video_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class VipHomePage extends StatefulWidget {
  final GestureTapCallback? onLiveTap;
  const VipHomePage({Key? key, this.onLiveTap}) : super(key: key);

  @override
  State<VipHomePage> createState() => _VipHomePageState();
}

class _VipHomePageState extends State<VipHomePage> {
  final useWebUrls = [
    'm.bilibili.com',
    'm.youku.com',
    'm.v.qq.com',
    'm.iqiyi.com',
    'm.mgtv.com',
    'm.tv.sohu.com',
    'm.1905.com',
    'm.pptv.com',
    'm.le.com'
  ];
  final useWeb = [
    'B站',
    '优酷',
    '腾讯视频',
    '爱奇艺',
    '芒果',
    '搜狐视频',
    '1905',
    'PPTV',
    '乐视'
  ];
  final playLine = [
    {"name": "纯净1", "url": "https://im1907.top/?jx="},
    {"name": "B站1", "url": "https://jx.bozrc.com:4433/player/?url="},
    {"name": "爱豆", "url": "https://jx.aidouer.net/?url="},
    {"name": "CHok", "url": "https://www.gai4.com/?url="},
    {"name": "OK", "url": "https://okjx.cc/?url="},
    {"name": "RDHK", "url": "https://jx.rdhk.net/?v="},
    {"name": "人人迷", "url": "https://jx.blbo.cc:4433/?url="},
    {"name": "思古3", "url": "https://jsap.attakids.com/?url="},
    {"name": "听乐", "url": "https://jx.dj6u.com/?url="},
  ];

  late Map<String, String> _selectMap = playLine.first;

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 20,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('使用教程'),
                                  content: const Text(
                              '方法一：视频原始链接可以从正规的视频的App中，选择VIP视频，进行分享，会出现分享弹窗页面，点击「复制分享链接」，粘贴到输入框即可。'
                              '\n\n方法二：点击下面的视频网站，在视频网站的页面左侧会出现「VIP」的按钮，选择解析线路，就可观看VIP视频，若无法播放请更换解析线路后重试。'
                              '\n\n提示：本App仅供学习交流使用，禁止恶意传播，支持正版影视版权和网站，共建文明风尚。'
                              ),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('我知道了')),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(Icons.adb),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: widget.onLiveTap,
                        label: const Text('电视直播'),
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Align(
                      alignment: Alignment.center,
                      child: Text(
                        '极简解析',
                        style: TextStyle(fontSize: 30),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Text('选择解析线路：'),
                      DropdownButton(
                          items: playLine.map((e) {
                            return DropdownMenuItem(
                              child: Text('${e['name']}'),
                              value: e,
                            );
                          }).toList(),
                          value: _selectMap,
                          onChanged: (Map<String, String>? e) {
                            setState(() {
                              _selectMap = e!;
                            });
                          }),
                    ],
                  ),
                  TextField(
                    controller: _textController,
                    decoration: const InputDecoration(hintText: '请输入视频原始链接'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final value = _textController.text.trim();
                        if (value.isEmpty) return;
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => WebVideoPage(
                                videoUrl:
                                    '${_selectMap['url']}${_textController.text}')));
                      },
                      child: const Text('开始解析')),
                  const SizedBox(
                    height: 44,
                  ),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: List.generate(useWeb.length, (index) {
                      return ElevatedButton(
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black12),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => EasyWebPage(
                                  videoUrl: 'https://${useWebUrls[index]}')));
                        },
                        child: Text(
                          useWeb[index],
                          textAlign: TextAlign.center,
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  child: const Text(
                    '鼓励支持正版，共建版权氛围',
                    style: TextStyle(color: Colors.black45),
                  )))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
