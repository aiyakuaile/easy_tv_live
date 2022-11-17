import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EasyWebPage extends StatefulWidget {
  final String videoUrl;
  final bool isParse;
  const EasyWebPage({Key? key,required this.videoUrl,this.isParse = true}) : super(key: key);

  @override
  State<EasyWebPage> createState() => _EasyWebPageState();
}

class _EasyWebPageState extends State<EasyWebPage> {

  WebViewController? _webViewController;

  String? _javaScriptString;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if(widget.isParse){
      rootBundle.loadString('assets/resources/user.js').then((value){
        _javaScriptString = value;
        _webViewController?.runJavascriptReturningResult(_javaScriptString!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        final isBack = (await _webViewController?.canGoBack()) ?? false;
        if(isBack){
          _webViewController!.goBack();
        }else{
          Navigator.of(context).pop();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('视频'),
          leadingWidth: 100,
          automaticallyImplyLeading: false,
          leading: Row(
            children: [
              IconButton(onPressed: ()async{
                final isBack = (await _webViewController?.canGoBack()) ?? false;
                if(isBack){
                  _webViewController!.goBack();
                }else{
                  Navigator.of(context).pop();
                }
              }, icon: const Icon(Icons.arrow_back)),
              IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: const Icon(Icons.clear)),
            ],
          ),
        ),

        body: WebView(
          initialUrl: widget.videoUrl,
          allowsInlineMediaPlayback: false,
          zoomEnabled: false,
          gestureNavigationEnabled: true,
          javascriptMode:JavascriptMode.unrestricted,
          onWebViewCreated: (controller){
            _webViewController = controller;
          },
          onPageFinished: (url)async{
            if(_javaScriptString == null) return;
            final res = await _webViewController?.runJavascriptReturningResult(_javaScriptString!);
            'onPageFinished========$res';
          },
          navigationDelegate: (request)async{
            debugPrint('request======${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}
