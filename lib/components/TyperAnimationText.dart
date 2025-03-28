import 'package:flutter/material.dart';

class TyperAnimationText extends StatefulWidget {
  final TextStyle? style;
  final Duration? duration;
  final Duration? delayToRepeat;
  final String text;
  final bool? repeat;
  const TyperAnimationText({
    this.style,
    super.key,
    this.duration,
    this.repeat = false,
    this.delayToRepeat,
    required this.text,
  });

  @override
  State<TyperAnimationText> createState() => _TyperAnimationTextState();
}

class _TyperAnimationTextState extends State<TyperAnimationText> {
  int currentIndex = -1;

  @override
  void initState() {
    _anim();
    super.initState();
  }

  void _anim() {
    if (currentIndex < widget.text.length) {
      currentIndex++;
    } else {
      if (widget.repeat != false) {
        Future.delayed(
          widget.delayToRepeat ?? const Duration(milliseconds: 300),
          () => currentIndex = -1,
        );
      }
    }
    Future.delayed(
      widget.duration ?? const Duration(milliseconds: 200),
      () => setState(() {
        _anim();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text.substring(0, currentIndex),
      style: widget.style,
    );
  }
}
