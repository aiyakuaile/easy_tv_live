import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(formats: [BarcodeFormat.qrCode]);

  String? _code;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    unawaited(controller.start());
    super.initState();
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    await controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('扫一扫'),
      ),
      body: MobileScanner(
        controller: controller,
        onDetect: (result) async {
          if (_code != null && _code!.isNotEmpty) return;
          _code = result.barcodes.first.displayValue;
          if (_code != null && _code!.isNotEmpty) {
            await controller.stop();
            debugPrint('onCapture::::$_code');
            Navigator.pop(context, _code);
          }
        },
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.isInitialized) {
      return;
    }
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(controller.stop());
    }
  }
}
