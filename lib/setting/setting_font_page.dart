import 'package:easy_tv_live/provider/theme_provider.dart';
import 'package:easy_tv_live/util/font_util.dart';
import 'package:easy_tv_live/util/http_util.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entity/font_model.dart';
import '../util/env_util.dart';

class SettingFontPage extends StatefulWidget {
  final bool isTV;
  const SettingFontPage({super.key, this.isTV = false});

  @override
  State<SettingFontPage> createState() => _SettingFontPageState();
}

class _SettingFontPageState extends State<SettingFontPage> {
  final _fontLink = EnvUtil.fontLink();
  final _fontDownloadLink = EnvUtil.fontDownloadLink();
  final _fontList = <FontModel>[];
  final _fontScales = [1.0, 1.2, 1.4, 1.6, 1.8];

  @override
  void initState() {
    _loadFontList();
    super.initState();
  }

  _loadFontList() async {
    final res = await HttpUtil().getRequest('$_fontLink/font.json');
    if (res != null) {
      _fontList.clear();
      _fontList.addAll((res as List).map((e) => FontModel.fromJson(e)).toList());
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isTV ? const Color(0xFF1E2022) : null,
      appBar: AppBar(
        leading: widget.isTV ? const SizedBox.shrink() : null,
        title: const Text('字体设置'),
        backgroundColor: widget.isTV ? const Color(0xFF1E2022) : null,
      ),
      body: Consumer<ThemeProvider>(builder: (BuildContext context, ThemeProvider themeProvider, Widget? child) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '字体大小',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      _fontScales.length,
                      (index) => ChoiceChip(
                        onSelected: (bool selected) {
                          themeProvider.setTextScale(_fontScales[index]);
                        },
                        shape: const StadiumBorder(),
                        label: Text(
                          '${_fontScales[index]}',
                          style: const TextStyle(fontSize: 15),
                        ),
                        selected: themeProvider.textScaleFactor == _fontScales[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.separated(
                itemCount: _fontList.length,
                padding: const EdgeInsets.all(15),
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 15);
                },
                itemBuilder: (context, index) {
                  final model = _fontList[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      height: 80,
                      color: const Color(0xFF2B2D30),
                      child: Stack(
                        children: [
                          Container(
                            height: 80,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Text(
                                  model.fontName!,
                                  style: const TextStyle(fontSize: 17),
                                ),
                                const Spacer(),
                                Builder(builder: (context) {
                                  return ElevatedButton(
                                    onPressed: themeProvider.fontFamily == model.fontKey
                                        ? null
                                        : () async {
                                            if (model.progress != 0.0) return;
                                            if (model.fontKey == 'system') {
                                              themeProvider.setFontFamily(model.fontKey!);
                                              return;
                                            }
                                            final fontUrl = '$_fontDownloadLink/${model.fontKey!}.${model.fontType}';
                                            final res = await FontUtil().loadFont(fontUrl, model.fontKey!, progressCallback: (double progress) {
                                              LogUtil.v('progress=========$progress');
                                              setState(() {
                                                model.progress = progress;
                                              });
                                            });
                                            if (res && context.mounted) {
                                              setState(() {
                                                model.progress = 0.0;
                                              });
                                              themeProvider.setFontFamily(model.fontKey!, fontUrl);
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(80, 40),
                                      padding: EdgeInsets.zero,
                                      disabledBackgroundColor: themeProvider.fontFamily == model.fontKey ? Colors.redAccent : null,
                                    ),
                                    child: Text(
                                      model.progress != 0.0
                                          ? '下载中'
                                          : themeProvider.fontFamily == model.fontKey
                                              ? '使用中'
                                              : '使用',
                                      style: TextStyle(color: themeProvider.fontFamily == model.fontKey ? Colors.white : null),
                                    ),
                                    onFocusChange: (bool isFocus) {
                                      if (isFocus) {
                                        Scrollable.ensureVisible(context,
                                            alignment: 0.5, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                      }
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                          if (model.progress! > 0)
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: LinearProgressIndicator(
                                value: model.progress,
                                minHeight: 2,
                                backgroundColor: Colors.transparent,
                                color: Colors.redAccent,
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
