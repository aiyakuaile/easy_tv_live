import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_tv_live/subscribe/subScribe_model.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:easy_tv_live/util/m3u_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sp_util/sp_util.dart';

class SubScribePage extends StatefulWidget {
  const SubScribePage({Key? key}) : super(key: key);

  @override
  State<SubScribePage> createState() => _SubScribePageState();
}

class _SubScribePageState extends State<SubScribePage> {
  List<SubScribeModel> _m3uList = <SubScribeModel>[];

  bool _isClickRefresh = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    final res = await M3uUtil.getLocalData();
    setState(() {
      _m3uList = res;
    });
  }

  _refreshData(SubScribeModel model, int index) async {
    _isClickRefresh = true;
    final res = await M3uUtil.refreshM3uLink(
        model.link == 'default' ? M3uUtil.defaultM3u : model.link!);
    if (res.isNotEmpty) {
      final sub = SubScribeModel(
          time: '当前链接无效，请删除',
          link: model.link,
          result: res,
          selected: model.selected);
      _m3uList[index] = sub;
      await M3uUtil.saveLocalData(_m3uList);
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(_isClickRefresh);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('订阅'),
          elevation: 0,
          actions: [
            TextButton(
              onPressed: _addM3uSource,
              child: const Text('添加'),
            )
          ],
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final model = _m3uList[index];
                    return Card(
                      color: model.selected == true
                          ? Colors.redAccent.withOpacity(0.8)
                          : Colors.transparent,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.link == 'default'
                                  ? model.link!
                                  : model.link!.split('/').last.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '上次刷新：${model.time}',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 12),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Spacer(),
                                if (model.selected != true &&
                                    model.link != 'default')
                                  TextButton(
                                      onPressed: () async {
                                        final isDelete = await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content:
                                                    const Text('确定删除此订阅吗？'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, false);
                                                      },
                                                      child: const Text('取消')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, true);
                                                      },
                                                      child: const Text('确定')),
                                                ],
                                              );
                                            });
                                        if (isDelete == true) {
                                          _isClickRefresh = true;
                                          _m3uList.removeAt(index);
                                          await M3uUtil.saveLocalData(_m3uList);
                                          setState(() {});
                                        }
                                      },
                                      child: const Text('删除')),
                                if (model.selected != true && model.result != 'error')
                                  TextButton(
                                      onPressed: () async {
                                        _isClickRefresh = true;
                                        if (model.result == null ||
                                            model.result == '') {
                                          EasyLoading.showToast('请刷新成功后再试');
                                          return;
                                        }
                                        for (var element in _m3uList) {
                                          element.selected = false;
                                        }
                                        if (model.selected != true) {
                                          model.selected = true;
                                          await M3uUtil.saveLocalData(_m3uList);
                                          setState(() {});
                                        }
                                      },
                                      child: const Text('设为默认')),
                                TextButton(
                                    onPressed: () {
                                      _isClickRefresh = true;
                                      _refreshData(model, index);
                                    },
                                    child: const Text('刷新')),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: _m3uList.length),
            ),
            const Text(
              '如遇视频源失效，请刷新对应的订阅的链接',
              style: TextStyle(color: Color(0xFF999999)),
            ),
            RichText(
              text:  TextSpan(
                  style: const TextStyle(color: Color(0xFF999999),fontFamily: 'Kaiti'),
                  children: [
                    const TextSpan(text: '如需增加额外的iPTV直播源，'),
                    TextSpan(
                        text: '请前往Github>>',
                        recognizer: TapGestureRecognizer()..onTap = ()async{
                          await launch('https://github.com/iptv-org/iptv');
                        },
                        style:
                            const TextStyle(color: Colors.blue)),
                  ]),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 10)
          ],
        ),
      ),
    );
  }

  _addM3uSource() async {
    final res = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        builder: (context) {
          final _textController = TextEditingController();
          return SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context,_) {
                return SizedBox(
                  height: 120 + MediaQuery.of(context).viewInsets.bottom,
                  child: Column(
                    children: [
                      SizedBox.fromSize(
                        size: const Size.fromHeight(44),
                        child: AppBar(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          title: const Text('添加订阅源'),
                          centerTitle: true,
                          automaticallyImplyLeading: false,
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, _textController.text);
                                },
                                child: const Text('确定'))
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextField(
                            controller: _textController,
                            autofocus: true,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: '请输入或粘贴m3u格式的订阅源链接',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 20,
                      )
                    ],
                  ),
                );
              }
            ),
          );
        });
    if (res == null || res == '') return;
    final hasIndex = _m3uList.indexWhere((element) => element.link == res);
    if (hasIndex != -1) {
      EasyLoading.showToast('已添加过此订阅');
    }
    if (res.startsWith('http') && hasIndex == -1) {
      LogUtil.v('添加：$res');
      final m3uRes = await M3uUtil.refreshM3uLink(res, isAdd: true);
      if (m3uRes.isNotEmpty) {
        if(m3uRes == 'error') return;
        final sub = SubScribeModel(
            time: DateUtil.formatDate(DateTime.now(), format: DateFormats.full),
            link: res,
            result: m3uRes,
            selected: false);
        _m3uList.add(sub);
        await M3uUtil.saveLocalData(_m3uList);
        _isClickRefresh = true;
        setState(() {});
      }else{
        final sub = SubScribeModel(
            time: '请刷新重试',
            link: res,
            result: '',
            selected: false);
        _m3uList.add(sub);
        await M3uUtil.saveLocalData(_m3uList);
        setState(() {});
      }
    } else {
      EasyLoading.showToast('请输入http/https链接');
    }
  }
}
