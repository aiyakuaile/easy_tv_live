import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebVideoPage extends StatefulWidget {
  final String videoUrl;
  const WebVideoPage({Key? key,required this.videoUrl}) : super(key: key);

  @override
  State<WebVideoPage> createState() => _WebVideoPageState();
}

class _WebVideoPageState extends State<WebVideoPage> {

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.centerRight,
          children: [
            Positioned.fill(
              child: WebView(
                initialUrl: '',
                allowsInlineMediaPlayback: true,
                initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
                zoomEnabled: false,
                gestureNavigationEnabled: false,
                javascriptMode:JavascriptMode.unrestricted,
                onWebViewCreated: (controller){
                  controller.loadUrl(widget.videoUrl);
                },
                navigationDelegate: (request)async{
                  if(!request.url.startsWith('http')){
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            ),
            Positioned(
                right: 20,
                top: 20,
                child: TextButton.icon(onPressed: (){
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                  Navigator.pop(context);
                }, icon: const Icon(Icons.exit_to_app),label: const Text('退出'),)
            )
          ],
        ),
      ),
    );
  }
}
