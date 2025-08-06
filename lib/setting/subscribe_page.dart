import 'dart:convert';
import 'dart:io';

import 'package:easy_tv_live/tv/html_string.dart';
import 'package:easy_tv_live/util/date_util.dart';
import 'package:easy_tv_live/util/device_sync_util.dart';
import 'package:easy_tv_live/util/http_util.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:easy_tv_live/util/m3u_util.dart';
import 'package:easy_tv_live/widget/focus_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:sp_util/sp_util.dart';

import '../entity/sub_scribe_model.dart';
import '../generated/l10n.dart';
import '../util/env_util.dart';

class SubScribePage extends StatefulWidget {
  final bool isTV;
  final String? remoteIp;

  const SubScribePage({super.key, this.isTV = false, this.remoteIp});

  @override
  State<SubScribePage> createState() => _SubScribePageState();
}

class _SubScribePageState extends State<SubScribePage> {
  AppLifecycleListener? _appLifecycleListener;

  List<SubScribeModel> _m3uList = <SubScribeModel>[];

  HttpServer? _server;

  String? _address;
  String? _ip;
  late String? _remoteIP = widget.remoteIp;
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

  _bindRemoteIP() async {
    if (EnvUtil.isTV() || _remoteIP == null || _remoteIP == '') return;
    final response = await HttpUtil().postRequest('http://$_remoteIP:$_port/ip', data: {'ip': _ip});
    if (response != null) {
      EasyLoading.showToast('设备已连接');
    } else {
      setState(() {
        _remoteIP = null;
      });
      EasyLoading.showToast('连接失败');
    }
  }

  _addLifecycleListen() {
    if (EnvUtil.isTV()) return;
    _appLifecycleListener = AppLifecycleListener(
      onStateChange: (state) {
        LogUtil.v('addLifecycleListen::::::$state');
        if (state == AppLifecycleState.resumed) {
          _pasteClipboard();
        }
      },
    );
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
        },
      );
      if (res == true) {
        await _pareUrl(clipText);
      }
      Clipboard.setData(const ClipboardData(text: ''));
    }
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

  _localNet() async {
    try {
      _ip = await NetworkInfo().getWifiIP();
    } catch (e) {
      LogUtil.v(e.toString());
    }
    LogUtil.v('_ip::::$_ip');
    if (_ip == null || _ip == '') {
      _ip = await getCurrentIP();
      if (_ip == null || _ip == '') {
        EasyLoading.showToast('无法获取本机IP');
        return;
      }
    }
    await _bindRemoteIP();
    _server = await HttpServer.bind(_ip, _port);
    _address = 'http://$_ip:$_port';
    setState(() {});
    await for (HttpRequest request in _server!) {
      if (request.method == 'GET') {
        request.response
          ..headers.contentType = ContentType.html
          ..write(getHtmlString(_address!))
          ..close();
      } else if (request.method == 'POST') {
        String content = await utf8.decoder.bind(request).join();
        Map<String, dynamic> data = jsonDecode(content);
        switch (request.uri.path) {
          case '/':
            _handleRootPost(request, data);
            break;
          case '/sync':
            _handleSyncPost(request, data);
            break;
          case '/ip':
            _handleIpPost(request, data);
            break;
          case '/exit':
            _handleIpExitPost();
            request.response
              ..statusCode = HttpStatus.ok
              ..headers.contentType = ContentType.json
              ..write(json.encode({'msg': 'exit success!!!'}))
              ..close();
            break;
          default:
            request.response
              ..statusCode = HttpStatus.notFound
              ..write('Not found')
              ..close();
        }
      } else {
        request.response
          ..statusCode = HttpStatus.methodNotAllowed
          ..write('Unsupported request: ${request.method}. Only POST requests are allowed.')
          ..close();
      }
    }
  }

  _handleRootPost(HttpRequest request, Map<String, dynamic> data) async {
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
  }

  _handleSyncPost(HttpRequest request, Map<String, dynamic> data) async {
    request.response
      ..statusCode = HttpStatus.ok
      ..headers.contentType = ContentType.json
      ..write(json.encode({'msg': '同步成功'}))
      ..close();
    await DeviceSyncUtil.applyAllSettings(context, data);
    _getData();
  }

  _handleIpPost(HttpRequest request, Map<String, dynamic> data) async {
    _remoteIP = data['ip'] as String?;
    setState(() {});
    request.response
      ..statusCode = HttpStatus.ok
      ..headers.contentType = ContentType.json
      ..write(json.encode({'msg': 'bind Ip success'}))
      ..close();
  }

  _handleIpExitPost() {
    _remoteIP = null;
    setState(() {});
    EasyLoading.showToast('连接已断开');
  }

  _getData() async {
    final res = await M3uUtil.getLocalData();
    setState(() {
      _m3uList = res;
    });
  }

  @override
  void dispose() {
    if (_remoteIP != null) HttpUtil().postRequest('http://$_remoteIP:$_port/exit', data: {'ip': _ip}, isShowLoading: false);
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
        actions: [
          TextButton(onPressed: _addLocalM3u, child: Text('本地添加')),
          TextButton(onPressed: _addM3uSource, child: Text('网络添加')),
        ],
      ),
      body: Column(
        children: [
          if ((Platform.isAndroid || Platform.isIOS) && !widget.isTV && _remoteIP != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              color: Colors.green.withValues(alpha: 0.3),
              child: Row(
                children: [
                  const Text('设备连接成功，可以同步啦！'),
                  const Spacer(),
                  TextButton(onPressed: _showSyncBottomSheet, child: const Text('立即同步')),
                ],
              ),
            ),
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
                      return Builder(
                        builder: (context) {
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
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: _m3uList.length,
                  ),
                ),
                if (widget.isTV || !EnvUtil.isMobile) const VerticalDivider(),
                if ((widget.isTV || !EnvUtil.isMobile) && (_remoteIP == null || _remoteIP == ''))
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(S.current.tvScanTip, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Container(
                            decoration: const BoxDecoration(color: Colors.white),
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            width: 150,
                            child: _address == null ? null : PrettyQrView.data(data: _address!),
                          ),
                          if (_address != null)
                            Container(margin: const EdgeInsets.only(bottom: 20), child: Text(S.current.pushAddress(_address ?? ''))),
                          Text(S.current.tvPushContent),
                        ],
                      ),
                    ),
                  ),
                if (widget.isTV && (_remoteIP != null && _remoteIP != ''))
                  Expanded(
                    child: ListView(
                      children: [
                        const Text('设备连接成功\n您可以同步下列数据到移动端：'),
                        const SizedBox(height: 12),
                        ListTile(
                          title: const Text('同步所有设置'),
                          onTap: () {
                            _syncData(0);
                          },
                        ),
                        ListTile(
                          title: const Text('同步订阅源'),
                          onTap: () {
                            _syncData(1);
                          },
                        ),
                        ListTile(
                          title: const Text('同步字体设置'),
                          onTap: () {
                            _syncData(2);
                          },
                        ),
                        ListTile(
                          title: const Text('同步美化设置'),
                          onTap: () {
                            _syncData(3);
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (!widget.isTV)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(S.current.pasterContent, style: const TextStyle(color: Color(0xFF999999))),
            ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
        ],
      ),
    );
  }

  _addLocalM3u() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['m3u', 'm3u8', 'txt']);
    if (result != null) {
      File file = File(result.files.single.path!);
      LogUtil.v('添加本地订阅源::::：${file.path}');
      final hasIndex = _m3uList.indexWhere((element) => element.link == file.path);
      LogUtil.v('添加:hasIndex:::：$hasIndex');
      if (hasIndex != -1) {
        EasyLoading.showToast(S.current.addRepeat);
        return;
      }
      final sub = SubScribeModel(
        time: DateUtil.formatDate(DateTime.now(), format: DateFormats.full),
        link: file.path,
        selected: false,
        local: true,
      );
      _m3uList.add(sub);
      await M3uUtil.saveLocalData(_m3uList);
      setState(() {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_scrollController.positions.isNotEmpty) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      });
    }
  }

  _addM3uSource() async {
    final textController = TextEditingController();
    final res = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      builder: (context) {
        return SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, _) {
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
                              Navigator.pop(context, textController.text);
                            },
                            child: Text(S.current.dialogConfirm),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: TextField(
                          controller: textController,
                          autofocus: true,
                          maxLines: 1,
                          decoration: InputDecoration(hintText: S.current.addFiledHintText, border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
    if (res == null || res == '') return;
    _pareUrl(res);
  }

  _pareUrl(String res) async {
    LogUtil.v('添加网络订阅源::::：$res');
    final hasIndex = _m3uList.indexWhere((element) => element.link == res);
    LogUtil.v('添加:hasIndex:::：$hasIndex');
    if (hasIndex != -1) {
      EasyLoading.showToast(S.current.addRepeat);
      return;
    }
    if (res.startsWith('http') && hasIndex == -1) {
      LogUtil.v('添加：$res');
      final sub = SubScribeModel(
        time: DateUtil.formatDate(DateTime.now(), format: DateFormats.full),
        link: res,
        selected: false,
      );
      _m3uList.add(sub);
      await M3uUtil.saveLocalData(_m3uList);
      setState(() {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_scrollController.positions.isNotEmpty) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      });
    } else {
      EasyLoading.showToast(S.current.addNoHttpLink);
    }
  }

  _showSyncBottomSheet() async {
    final res = await showModalBottomSheet<int>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('数据同步', style: TextStyle(fontSize: 15)),
            ),
            const Divider(thickness: 1, height: 1),
            ListTile(
              title: const Text('同步所有设置'),
              onTap: () {
                Navigator.pop(context, 0);
              },
            ),
            ListTile(
              title: const Text('同步订阅源'),
              onTap: () {
                Navigator.pop(context, 1);
              },
            ),
            ListTile(
              title: const Text('同步字体设置'),
              onTap: () {
                Navigator.pop(context, 2);
              },
            ),
            ListTile(
              title: const Text('同步美化设置'),
              onTap: () {
                Navigator.pop(context, 3);
              },
            ),
          ],
        );
      },
    );
    if (res == null) return;
    _syncData(res);
  }

  _syncData(int type) async {
    EasyLoading.show(status: '开始同步');
    Map<String, dynamic> params = switch (type) {
      0 => await DeviceSyncUtil.syncAllSettings(context),
      1 => await DeviceSyncUtil.syncVideoList(),
      2 => await DeviceSyncUtil.syncFont(context),
      3 => await DeviceSyncUtil.syncPrettify(context),
      _ => {},
    };
    final response = await HttpUtil().postRequest('http://$_remoteIP:$_port/sync', data: params, isShowLoading: false);
    if (response != null) {
      EasyLoading.showSuccess('同步成功');
    } else {
      EasyLoading.showToast('同步失败');
    }
  }
}
