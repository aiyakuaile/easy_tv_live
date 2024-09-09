import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FocusButton extends StatefulWidget {
  final String title;
  final bool selected;
  final GestureTapCallback? onTap;
  final ValueChanged<bool>? onFocusChange;
  final bool autofocus;
  final double? fontSize;
  const FocusButton({super.key, this.title = '', this.selected = false, this.onTap, this.autofocus = false, this.onFocusChange, this.fontSize});

  @override
  State<FocusButton> createState() => _FocusButtonState();
}

class _FocusButtonState extends State<FocusButton> {
  late bool _isFocus = widget.autofocus;
  late bool _isSelected = widget.selected;

  @override
  void didUpdateWidget(covariant FocusButton oldWidget) {
    if (oldWidget.selected != widget.selected) {
      setState(() {
        _isSelected = widget.selected;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
        onFocusChange: (bool isFocus) {
          setState(() {
            _isFocus = isFocus;
          });
          widget.onFocusChange?.call(isFocus);
        },
        onKeyEvent: (FocusNode node, KeyEvent event) {
          final isUpKey = event is KeyUpEvent;
          if (!isUpKey || _isSelected) return KeyEventResult.ignored;
          if (event.logicalKey == LogicalKeyboardKey.select) {
            _isSelected = true;
            setState(() {});
            widget.onTap?.call();
          }
          return KeyEventResult.ignored;
        },
        autofocus: widget.autofocus,
        child: PhysicalModel(
          shadowColor: _isFocus ? Colors.redAccent : Colors.transparent,
          elevation: _isFocus ? 30 : 0,
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isSelected = true;
              });
              widget.onTap?.call();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              constraints: const BoxConstraints(minWidth: 60),
              padding: _isFocus ? const EdgeInsets.symmetric(horizontal: 30, vertical: 10) : const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: buttonBackgroundColor(),
                border: Border.all(
                  width: 1,
                  color: buttonBorderColor(),
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                widget.title,
                style: TextStyle(color: buttonTextColor(), fontSize: widget.fontSize),
              ),
            ),
          ),
        ));
  }

  Color buttonBackgroundColor() {
    if (_isSelected) {
      return Colors.transparent;
    }
    if (_isFocus) {
      return Colors.redAccent;
    }
    return const Color(0xFF393B40);
  }

  Color buttonBorderColor() {
    if (_isSelected) {
      return Colors.redAccent;
    }
    return const Color(0xFF393B40);
  }

  Color buttonTextColor() {
    if (_isSelected) {
      return Colors.redAccent;
    }
    if (_isFocus) {
      return Colors.white;
    }
    return Colors.white54;
  }
}
