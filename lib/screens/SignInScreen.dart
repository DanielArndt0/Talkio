import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/components/SignInButton.dart';
import 'package:training_app/components/SignInDivider.dart';
import 'package:training_app/components/TalkyLogo.dart';
import 'package:training_app/controllers/SignInController.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController _controller = Provider.of<SignInController>(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(),
              const TalkyLogo(),
              const SizedBox(height: 50),
              Column(
                // Seção de buttons
                children: [
                  SignInButton(
                    label: 'Sign in with ',
                    loginType: const TalkyLogo(size: 16),
                    onPressed: _controller.loginWithTalkyButton,
                  ),
                  const SizedBox(height: 30),
                  const SignInDivider(),
                  const SizedBox(height: 30),
                  SignInButton(
                    label: 'Continue with Google',
                    onPressed: _controller.loginWithGoogleButton,
                    icon: Image.asset(
                      'assets/images/Google.png',
                      height: 16,
                      width: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SignInButton(
                    label: 'Continue with Facebook',
                    onPressed: _controller.loginWithFacebookButton,
                    icon: Image.asset(
                      'assets/images/Facebook.png',
                      height: 16,
                      width: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SignInButton(
                    label: 'Continue with phone',
                    onPressed: _controller.loginWithPhoneButton,
                    icon: const Icon(Icons.phone),
                  ),
                  const SizedBox(height: 56),
                  // SignUpButton
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
