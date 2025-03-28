import 'package:flutter/material.dart';

class SignInComponent extends StatelessWidget {
  final void Function()? onPressed;
  const SignInComponent({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Already have an account?'),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'Sign In Here',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
