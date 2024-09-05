import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:screen_brightness/screen_brightness.dart';

class VolumeBrightnessWidget extends StatefulWidget {
  const VolumeBrightnessWidget({super.key});

  @override
  State<VolumeBrightnessWidget> createState() => _VolumeBrightnessWidgetState();
}

class _VolumeBrightnessWidgetState extends State<VolumeBrightnessWidget> {
  double _volume = 0.5;
  double _brightness = 0.5;

  // 1.brightness
  // 2.volume
  int _controlType = 0;

  @override
  void initState() {
    _loadSystemData();
    super.initState();
  }

  _loadSystemData() async {
    _brightness = await ScreenBrightness().current;
    _volume = await FlutterVolumeController.getVolume() ?? 0.5;
    await FlutterVolumeController.updateShowSystemUI(false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(44),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragStart: (DragStartDetails details) {
          final width = MediaQuery.of(context).size.width;
          if (details.localPosition.dx > width / 2) {
            _controlType = 2;
          } else {
            _controlType = 1;
          }
        },
        onVerticalDragUpdate: (DragUpdateDetails details) {
          if (_controlType == 2) {
            _volume = (_volume + (-details.delta.dy / 500)).clamp(0.0, 1.0);
            FlutterVolumeController.setVolume(_volume);
          } else {
            _brightness =
                (_brightness + (-details.delta.dy / 500)).clamp(0.0, 1.0);
            ScreenBrightness().setScreenBrightness(_brightness);
          }
          setState(() {});
        },
        onVerticalDragEnd: (DragEndDetails details) {
          setState(() {
            _controlType = 0;
          });
        },
        onVerticalDragCancel: () {
          setState(() {
            _controlType = 0;
          });
        },
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 20),
          child: _controlType == 0
              ? null
              : Container(
                  width: 150,
                  height: 30,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _controlType == 1
                            ? Icons.light_mode
                            : Icons.volume_up_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: _controlType == 1 ? _brightness : _volume,
                          backgroundColor: Colors.white.withOpacity(0.5),
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
