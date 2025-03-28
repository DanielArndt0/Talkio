import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final void Function()? onPressed;
  const SignUpButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Don\'t have an account? Create here!'),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'Sign Up Here',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
