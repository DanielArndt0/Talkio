import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/services/AuthService.dart';

class SignUpProfileScreen extends StatelessWidget {
  const SignUpProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            authService.signOut();
          },
          child: const Text('SignOut'),
        ),
      ),
    );
  }
}
