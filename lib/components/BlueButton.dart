import 'package:flutter/material.dart';
import 'package:talkio/app/AppColors.dart';

class BlueButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? loginType;
  final String text;
  const BlueButton({
    required this.onPressed,
    required this.text,
    this.loginType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryMaterialColor,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                loginType ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
