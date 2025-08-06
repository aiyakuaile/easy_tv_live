import 'package:flutter/material.dart';

import '../entity/sub_scribe_model.dart';
import '../generated/l10n.dart';
import 'package:path/path.dart' as p;

class FocusCard extends StatefulWidget {
  final SubScribeModel model;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onUse;
  const FocusCard({super.key, required this.model, required this.onDelete, this.onUse});

  @override
  State<FocusCard> createState() => _FocusCardState();
}

class _FocusCardState extends State<FocusCard> {
  _onFocusChange(bool isFocus) {
    if (isFocus) {
      Scrollable.ensureVisible(context, alignment: 0.5, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
  }

  _calcLinkName() {
    if (widget.model.link == 'default') {
      return S.current.defaultText;
    }
    if(widget.model.local == true) {
      return p.basename(widget.model.link ?? '');
    }
    return widget.model.link!.split('?').first.split('/').last.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 10, bottom: 12),
      decoration: BoxDecoration(
        color: widget.model.selected == true ? Colors.redAccent.withValues(alpha: 0.5) : const Color(0xFF2B2D30),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.model.local == true)
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xA4A27672), borderRadius: BorderRadius.circular(4)),
                  child: const Text('本地', style: TextStyle(color: Colors.yellow, fontSize: 12)),
                ),
              Text(
                _calcLinkName(),
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('${S.current.createTime}：${widget.model.time}', style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 14)),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              if (widget.model.selected != true && widget.model.link != 'default')
                TextButton(
                  onFocusChange: _onFocusChange,
                  onPressed: () async {
                    final isDelete = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          backgroundColor: const Color(0xFF393B40),
                          content: Text(S.current.dialogDeleteContent, style: const TextStyle(color: Colors.white, fontSize: 20)),
                          actions: [
                            TextButton(
                              autofocus: true,
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: Text(S.current.dialogCancel, style: const TextStyle(fontSize: 17)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text(S.current.dialogConfirm, style: const TextStyle(fontSize: 17)),
                            ),
                          ],
                        );
                      },
                    );
                    if (isDelete == true) {
                      widget.onDelete?.call();
                    }
                  },
                  child: Text(S.current.delete),
                ),
              TextButton(
                onFocusChange: _onFocusChange,
                onPressed: widget.model.selected != true ? widget.onUse : () {},
                child: Text(widget.model.selected != true ? S.current.setDefault : S.current.inUse),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
