import 'package:easy_tv_live/easy_web_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class VipHomePage extends StatefulWidget {
  final GestureTapCallback? onLiveTap;
  const VipHomePage({Key? key,this.onLiveTap}) : super(key: key);

  @override
  State<VipHomePage> createState() => _VipHomePageState();
}

class _VipHomePageState extends State<VipHomePage> {

  final useWebUrls = ['m.bilibili.com','m.youku.com','m.v.qq.com','m.iqiyi.com','m.mgtv.com','m.tv.sohu.com','m.1905.com','m.pptv.com','m.le.com'];
  final useWeb = ['B站','优酷','腾讯视频','爱奇艺','芒果','搜狐视频','1905','PPTV','乐视'];
  final playLine = [
    {"name":"纯净1","url":"https://z1.m1907.top/?jx="},
    {"name":"B站1","url":"https://jx.bozrc.com:4433/player/?url="},
    {"name":"爱豆","url":"https://jx.aidouer.net/?url="},
    {"name":"CHok","url":"https://www.gai4.com/?url="},
    {"name":"OK","url":"https://okjx.cc/?url="},
    {"name":"RDHK","url":"https://jx.rdhk.net/?v="},
    {"name":"人人迷","url":"https://jx.blbo.cc:4433/?url="},
    {"name":"思古3","url":"https://jsap.attakids.com/?url="},
    {"name":"听乐","url":"https://jx.dj6u.com/?url="},
  ];

  late Map<String,String> _selectMap = playLine.first;

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top+20,),
            Row(
              children: [
                const Spacer(),
                TextButton.icon(onPressed: widget.onLiveTap, label: const Text('电视直播'),icon: const Icon(Icons.arrow_forward),),
              ],
            ),
            const SizedBox(height: 100),
            const Text('极简解析',style: TextStyle(fontSize: 30),),
            const SizedBox(height: 50,),
            Row(
              children: [
                DropdownButton(items: playLine.map((e){
                  return DropdownMenuItem(child: Text('${e['name']}'),value: e,);
                }).toList(),value: _selectMap, onChanged: (Map<String,String>? e){
                  setState(() {
                    _selectMap = e!;
                  });
                }),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: '请输入视频原始链接'
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>EasyWebPage(videoUrl: '${_selectMap['url']}${_textController.text}')));
                }, child: const Text('解析'))
              ],
            ),
            const SizedBox(height: 44,),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: List.generate(useWeb.length, (index){
              return ElevatedButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(math.Random().nextInt(256), math.Random().nextInt(256), math.Random().nextInt(256), 1))
                ),
                onPressed: (){
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>EasyWebPage(videoUrl: 'https://${useWebUrls[index]}')));
                },
                child: Text(useWeb[index],textAlign: TextAlign.center,),
              );
            }),)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
