import 'dart:convert';
import 'dart:io';

import 'package:easy_tv_live/subscribe/subScribe_model.dart';
import 'package:easy_tv_live/tv/html_string.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:easy_tv_live/util/m3u_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:sp_util/sp_util.dart';

import '../util/env_util.dart';

class SubScribePage extends StatefulWidget {
  final bool isTV;

  const SubScribePage({Key? key, this.isTV = false}) : super(key: key);

  @override
  State<SubScribePage> createState() => _SubScribePageState();
}

class _SubScribePageState extends State<SubScribePage> {
  AppLifecycleListener? _appLifecycleListener;

  List<SubScribeModel> _m3uList = <SubScribeModel>[];

  bool _isClickRefresh = false;

  HttpServer? _server;

  String? _address;
  String? _ip;
  final _port = 8080;

  @override
  void initState() {
    super.initState();
    _localNet();
    _getData();
    _pasteClipboard();
    _addLifecycleListen();
  }

  _addLifecycleListen() {
    if (EnvUtil.isTV()) return;
    _appLifecycleListener = AppLifecycleListener(onStateChange: (state) {
      LogUtil.v('addLifecycleListen::::::$state');
      if (state == AppLifecycleState.resumed) {
        _pasteClipboard();
      }
    });
  }

  _pasteClipboard() async {
    if (EnvUtil.isTV()) return;
    final clipData = await Clipboard.getData(Clipboard.kTextPlain);
    final clipText = clipData?.text;
    if (clipText != null && clipText.startsWith('http')) {
      final res = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xff3C3F41),
              title: const Text('温馨提示'),
              content: Text('确定添加此数据源吗？\n$clipText'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('取消'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('确定'),
                ),
              ],
            );
          });
      if (res == true) {
        await _pareUrl(clipText);
      }
      Clipboard.setData(const ClipboardData(text: ''));
    }
  }

  _localNet() async {
    if (!EnvUtil.isTV()) return;
    _ip = await getCurrentIP();
    LogUtil.v('_ip::::$_ip');
    _server = await HttpServer.bind(_ip, _port);
    _address = 'http://$_ip:$_port';
    setState(() {});
    await for (var request in _server!) {
      if (request.method == 'GET') {
        request.response
          ..headers.contentType = ContentType.html
          ..write(getHtmlString(_address!))
          ..close();
      } else if (request.method == 'POST') {
        String content = await utf8.decoder.bind(request).join();
        Map<String, dynamic> data = jsonDecode(content);
        String rMsg = '参数错误';
        if (data.containsKey('url')) {
          final url = data['url'] as String?;
          if (url == '' || url == null || !url.startsWith('http')) {
            EasyLoading.showError('请推送正确的链接');
            rMsg = '请推送正确的链接';
          } else {
            rMsg = '推送成功';
            _pareUrl(url);
          }
        } else {
          LogUtil.v('Missing parameters');
        }

        final responseData = {'message': rMsg};

        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write(json.encode(responseData))
          ..close();
      } else {
        request.response
          ..statusCode = HttpStatus.methodNotAllowed
          ..write('Unsupported request: ${request.method}. Only POST requests are allowed.')
          ..close();
      }
    }
  }

  _getData() async {
    final res = await M3uUtil.getLocalData();
    setState(() {
      _m3uList = res;
    });
  }

  Future<String> getCurrentIP() async {
    String currentIP = '';
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          LogUtil.v('Name: ${interface.name}  IP Address: ${addr.address}  IPV4: ${InternetAddress.anyIPv4}');

          if (addr.type == InternetAddressType.IPv4 && addr.address.startsWith('192')) {
            currentIP = addr.address;
          }
        }
      }
    } catch (e) {
      LogUtil.v(e.toString());
    }
    return currentIP;
  }

  @override
  void dispose() {
    _server?.close(force: true);
    _appLifecycleListener?.dispose();
    super.dispose();
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
          centerTitle: true,
          actions: widget.isTV
              ? null
              : [
                  IconButton(
                    onPressed: _addM3uSource,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )
                ],
        ),
        body: Column(
          children: [
            Flexible(
              child: Row(
                children: [
                  SizedBox(
                    width: widget.isTV ? MediaQuery.of(context).size.width * 0.3 : MediaQuery.of(context).size.width,
                    child: ListView.separated(
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          final model = _m3uList[index];
                          return Card(
                            color: model.selected == true ? Colors.redAccent.withOpacity(0.5) : const Color(0xFF2B2D30),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.link == 'default' ? model.link! : model.link!.split('?').first.split('/').last.toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    '创建日期：${model.time}',
                                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Spacer(),
                                      if (model.selected != true && model.link != 'default')
                                        TextButton(
                                            onPressed: () async {
                                              final isDelete = await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                      backgroundColor: const Color(0xFF393B40),
                                                      content: const Text(
                                                        '确定删除此订阅吗？',
                                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(context, false);
                                                            },
                                                            child: const Text(
                                                              '取消',
                                                              style: TextStyle(fontSize: 17),
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(context, true);
                                                            },
                                                            child: const Text('确定', style: TextStyle(fontSize: 17))),
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
                                      TextButton(
                                        onPressed: model.selected != true
                                            ? () async {
                                                _isClickRefresh = true;
                                                for (var element in _m3uList) {
                                                  element.selected = false;
                                                }
                                                if (model.selected != true) {
                                                  model.selected = true;
                                                  await SpUtil.remove('m3u_cache');
                                                  await M3uUtil.saveLocalData(_m3uList);
                                                  setState(() {});
                                                }
                                              }
                                            : null,
                                        child: Text(model.selected != true ? '设为默认' : '使用中'),
                                      ),
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
                  if (widget.isTV) const VerticalDivider(),
                  if (widget.isTV)
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '扫码添加订阅源',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            decoration: const BoxDecoration(color: Colors.white),
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.all(15),
                            width: 100,
                            child: _address == null
                                ? null
                                : PrettyQrView.data(
                                    data: _address!,
                                    decoration: const PrettyQrDecoration(
                                      image: PrettyQrDecorationImage(
                                        image: AssetImage('assets/images/logo.png'),
                                      ),
                                    ),
                                  ),
                          ),
                          if (_address != null) Container(margin: const EdgeInsets.only(bottom: 20), child: Text('推送地址：$_address')),
                          const Text('在扫码结果页，输入新的订阅源，点击页面中的推送即可添加成功'),
                        ],
                      ),
                    ))
                ],
              ),
            ),
            if (!widget.isTV)
              const Text(
                '复制订阅源后，回到此页面可自动添加订阅源',
                style: TextStyle(color: Color(0xFF999999)),
              ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 10)
          ],
        ),
      ),
    );
  }

  _addM3uSource() async {
    final _textController = TextEditingController();
    final res = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        builder: (context) {
          return SingleChildScrollView(
            child: LayoutBuilder(builder: (context, _) {
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
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: TextField(
                          controller: _textController,
                          autofocus: true,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            hintText: '请输入或粘贴.m3u或.txt格式的订阅源链接',
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
            }),
          );
        });
    if (res == null || res == '') return;
    _pareUrl(res);
  }

  _pareUrl(String res) async {
    LogUtil.v('添加::::：$res');
    final hasIndex = _m3uList.indexWhere((element) => element.link == res);
    LogUtil.v('添加:hasIndex:::：$hasIndex');
    if (hasIndex != -1) {
      EasyLoading.showToast('已添加过此订阅源');
      return;
    }
    if (res.startsWith('http') && hasIndex == -1) {
      LogUtil.v('添加：$res');
      final sub = SubScribeModel(time: DateUtil.formatDate(DateTime.now(), format: DateFormats.full), link: res, selected: false);
      _m3uList.add(sub);
      await M3uUtil.saveLocalData(_m3uList);
      setState(() {});
    } else {
      EasyLoading.showToast('请输入http/https链接');
    }
  }
}
