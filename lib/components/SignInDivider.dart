import 'package:flutter/material.dart';

class SignInDivider extends StatelessWidget {
  final _color = 0xFF58616A;
  const SignInDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: Color(_color),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'or',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(_color),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: Color(_color),
            ),
          ),
        ],
      ),
    );
  }
}
