import 'package:flutter/material.dart';
import 'package:training_app/app/AppColors.dart';

class FutureBlueButton extends StatefulWidget {
  final Future<void> Function() onPressed;
  final Widget loader;
  final String text;
  final Widget? loginType;

  const FutureBlueButton({
    required this.loader,
    required this.onPressed,
    required this.text,
    this.loginType,
    super.key,
  });

  @override
  State<FutureBlueButton> createState() => _FutureBlueButtonState();
}

class _FutureBlueButtonState extends State<FutureBlueButton> {
  bool _loading = false;

  void _handlePress() async {
    setState(() {
      _loading = true;
    });
    await widget.onPressed();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: _handlePress,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryMaterialColor,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _loading
                ? widget.loader
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                      widget.loginType ?? const SizedBox(),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
