import 'dart:convert';
import 'dart:io';

import 'package:easy_tv_live/generated/l10n.dart';
import 'package:easy_tv_live/tv/html_string.dart';
import 'package:easy_tv_live/util/env_util.dart';
import 'package:easy_tv_live/util/remote_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import '../util/log_util.dart';

class SettingRemote extends StatefulWidget {
  const SettingRemote({super.key});

  @override
  State<SettingRemote> createState() => _SettingRemoteState();
}

class _SettingRemoteState extends State<SettingRemote> {
  HttpServer? _server;

  String? _address;
  String? _ip;
  final _port = 9928;

  late final _controller = TextEditingController(text: context.read<ThemeProvider>().remoteControlLink ?? '');

  _localNet() async {
    if (!EnvUtil.isTV()) return;
    _ip = await RemoteUtil.getCurrentIP();
    if (_ip == null || _ip == '') {
      EasyLoading.showToast('无法获取本机IP');
      return;
    }
    _server = await HttpServer.bind(_ip, _port);
    _address = 'http://$_ip:$_port';
    setState(() {});
    await for (HttpRequest request in _server!) {
      if (request.method == 'GET') {
        request.response
          ..headers.contentType = ContentType.html
          ..write(getHtmlString(_address!, '远程配置项'))
          ..close();
      } else if (request.method == 'POST') {
        String content = await utf8.decoder.bind(request).join();
        Map<String, dynamic> data = jsonDecode(content);
        switch (request.uri.path) {
          case '/':
            _handleRootPost(request, data);
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
        context.read<ThemeProvider>().setRemoteControlLink(url);
        _controller.text = url;
        _applyRemoteSetting();
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

  _applyRemoteSetting() async {
    EasyLoading.show(status: '处理远程配置');
    final isApply = await RemoteUtil.getRemoteData(context, false);
    if (isApply) {
      EasyLoading.showSuccess('应用配置成功');
    }
  }

  @override
  void initState() {
    _localNet();
    super.initState();
  }

  @override
  void dispose() {
    _server?.close(force: true);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showQR = EnvUtil.isTV() && _address != null;
    final querySize = MediaQuery.of(context).size;
    final isHorizontal = querySize.width > querySize.height;
    return Scaffold(
      appBar: isHorizontal ? null : AppBar(title: const Text('远程配置'), centerTitle: false),
      backgroundColor: isHorizontal ? const Color(0xFF1E2022) : null,
      body: SingleChildScrollView(
        child: Consumer<ThemeProvider>(
          builder: (BuildContext context, ThemeProvider themeProvider, Widget? child) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      themeProvider.isOpenRemoteControl ? '远程配置已生效，远程配置修改后将会覆盖应用内设置，请知悉' : '',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: _controller,
                          canRequestFocus: !EnvUtil.isTV(),
                          maxLines: 1,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                          decoration: const InputDecoration(hintText: '请输入远程配置地址', labelText: '远程配置地址'),
                          onChanged: (val) {
                            if (val.isEmpty) {
                              themeProvider.setRemoteControlLink('');
                            }
                          },
                        ),
                      ),
                      Gap(20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final url = _controller.text.trim();
                              if (url.isNotEmpty) {
                                if (url.startsWith('http')) {
                                  themeProvider.setRemoteControlLink(url);
                                  _applyRemoteSetting();
                                } else {
                                  EasyLoading.showToast('请输入可访问的http链接');
                                }
                              } else {
                                EasyLoading.showToast('请输入远程配置地址');
                              }
                            },
                            child: Text('应用远程配置'),
                          ),
                          Gap(20),
                          if (themeProvider.isOpenRemoteControl)
                            ElevatedButton(
                              onPressed: () {
                                themeProvider.setRemoteControlLink('');
                                _controller.text = '';
                              },
                              child: Text('删除远程配置'),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Gap(50),
                  if (showQR)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('手机扫描下方二维码进行推送远程配置地址', style: TextStyle(fontSize: 16)),
                        Gap(10),
                        Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          width: 150,
                          child: _address == null ? null : PrettyQrView.data(data: _address!),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
