import 'dart:convert';
import 'dart:io';

import 'package:easy_tv_live/tv/html_string.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:easy_tv_live/util/m3u_util.dart';
import 'package:easy_tv_live/widget/focus_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:sp_util/sp_util.dart';

import '../entity/subScribe_model.dart';
import '../generated/l10n.dart';
import '../util/env_util.dart';

class SubScribePage extends StatefulWidget {
  final bool isTV;

  const SubScribePage({super.key, this.isTV = false});

  @override
  State<SubScribePage> createState() => _SubScribePageState();
}

class _SubScribePageState extends State<SubScribePage> {
  AppLifecycleListener? _appLifecycleListener;

  List<SubScribeModel> _m3uList = <SubScribeModel>[];

  HttpServer? _server;

  String? _address;
  String? _ip;
  final _port = 8828;

  final _scrollController = ScrollController();

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
              title: Text(S.current.dialogTitle),
              content: Text('${S.current.dataSourceContent}\n$clipText'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(S.current.dialogCancel),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(S.current.dialogConfirm),
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
    if (_ip == null) return;
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
        String rMsg = S.current.tvParseParma;
        if (data.containsKey('url')) {
          final url = data['url'] as String?;
          if (url == '' || url == null || !url.startsWith('http')) {
            EasyLoading.showError(S.current.tvParsePushError);
            rMsg = S.current.tvParsePushError;
          } else {
            rMsg = S.current.tvParseSuccess;
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
    res.addAll([
      SubScribeModel(link: 'https://123.m3u', time: '2022-12-01 11:12:13'),
      SubScribeModel(link: 'https://456.m3u', time: '2022-12-01 11:12:13'),
      SubScribeModel(link: 'https://789.m3u', time: '2022-12-01 11:12:13'),
      SubScribeModel(link: 'https://0012.m3u', time: '2022-12-01 11:12:13'),
      SubScribeModel(link: 'https://5589.m3u', time: '2022-12-01 11:12:13'),
    ]);
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isTV ? const Color(0xFF1E2022) : null,
      appBar: AppBar(
        backgroundColor: widget.isTV ? const Color(0xFF1E2022) : null,
        title: Text(S.current.subscribe),
        centerTitle: true,
        leading: widget.isTV ? const SizedBox.shrink() : null,
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
                      padding: const EdgeInsets.all(12),
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        final model = _m3uList[index];
                        return Builder(builder: (context) {
                          return FocusCard(
                            model: model,
                            onDelete: () async {
                              _m3uList.removeAt(index);
                              await M3uUtil.saveLocalData(_m3uList);
                              setState(() {});
                            },
                            onUse: () async {
                              for (var element in _m3uList) {
                                element.selected = false;
                              }
                              if (model.selected != true) {
                                model.selected = true;
                                await SpUtil.remove('m3u_cache');
                                await M3uUtil.saveLocalData(_m3uList);
                                setState(() {});
                              }
                            },
                          );
                        });
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
                        Text(
                          S.current.tvScanTip,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          width: 150,
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
                        if (_address != null)
                          Container(margin: const EdgeInsets.only(bottom: 20), child: Text(S.current.pushAddress(_address ?? ''))),
                        Text(S.current.tvPushContent),
                      ],
                    ),
                  ))
              ],
            ),
          ),
          if (!widget.isTV)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                S.current.pasterContent,
                style: const TextStyle(color: Color(0xFF999999)),
              ),
            ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10)
        ],
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
                        title: Text(S.current.addDataSource),
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context, _textController.text);
                              },
                              child: Text(S.current.dialogConfirm))
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
                          decoration: InputDecoration(
                            hintText: S.current.addFiledHintText,
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
      EasyLoading.showToast(S.current.addRepeat);
      return;
    }
    if (res.startsWith('http') && hasIndex == -1) {
      LogUtil.v('添加：$res');
      final sub = SubScribeModel(time: DateUtil.formatDate(DateTime.now(), format: DateFormats.full), link: res, selected: false);
      _m3uList.add(sub);
      await M3uUtil.saveLocalData(_m3uList);
      setState(() {});
    } else {
      EasyLoading.showToast(S.current.addNoHttpLink);
    }
  }
}
