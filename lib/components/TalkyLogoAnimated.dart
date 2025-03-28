import 'package:flutter/material.dart';
import 'package:training_app/app/AppColors.dart';

class TalkyLogoAnimated extends StatefulWidget {
  final double? size;
  final Duration? duration;
  final Duration? delayToRepeat;
  final bool? repeat;
  const TalkyLogoAnimated({
    this.size = 60,
    super.key,
    this.duration,
    this.repeat = false,
    this.delayToRepeat,
  });

  @override
  State<TalkyLogoAnimated> createState() => _TalkyLogoAnimatedState();
}

class _TalkyLogoAnimatedState extends State<TalkyLogoAnimated> {
  String text = 'Talky';
  int currentIndex = -1;

  @override
  void initState() {
    _anim();
    super.initState();
  }

  void _anim() {
    if (currentIndex < text.length) {
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
    return Text.rich(
      TextSpan(
        text: text.substring(0, currentIndex),
        style: TextStyle(
          fontSize: widget.size,
          fontWeight: FontWeight.bold,
          color: AppColors.fontColor,
        ),
        children: [
          TextSpan(
            text: '.',
            style: TextStyle(
              fontSize: widget.size,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
