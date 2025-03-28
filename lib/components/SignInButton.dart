import 'package:flutter/material.dart';
import 'package:training_app/app/AppColors.dart';

class SignInButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? icon;
  final Widget? loginType;
  final String label;
  const SignInButton({
    required this.onPressed,
    required this.label,
    this.loginType,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton.icon(
            icon: icon ?? const SizedBox(),
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.fontColor,
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
