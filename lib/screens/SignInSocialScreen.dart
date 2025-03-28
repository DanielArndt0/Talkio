import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/app/AppColors.dart';
import 'package:training_app/components/AppFormField.dart';
import 'package:training_app/components/FutureBlueButton.dart';
import 'package:training_app/components/SignUpButton.dart';
import 'package:training_app/components/TalkyLogo.dart';
import 'package:training_app/controllers/SignInSocialController.dart';
import 'package:training_app/modals/ForgotPasswordModal.dart';
import 'package:training_app/validators/FormValidator.dart';

class SignInSocialScreen extends StatefulWidget {
  const SignInSocialScreen({super.key});

  @override
  State<SignInSocialScreen> createState() => _SignInSocialScreenState();
}

class _SignInSocialScreenState extends State<SignInSocialScreen>
    with FormValidator {
  late final SignInSocialController _controller;

  @override
  void initState() {
    _controller = context.read<SignInSocialController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(),
              const TalkyLogo(size: 40),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign in with ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  TalkyLogo(size: 18),
                ],
              ),
              const SizedBox(height: 40),
              Form(
                key: _controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        AppFormField(
                          labelText: 'Enter your e-mail',
                          hintText: 'example@email.com',
                          controller: _controller.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: isNotEmpty,
                        ),
                        const SizedBox(height: 18),
                        AppFormField(
                          labelText: 'Enter your password',
                          hintText: '••••••••',
                          controller: _controller.password,
                          keyboardType: TextInputType.visiblePassword,
                          validator: isNotEmpty,
                          obscureText: true,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => ForgotPasswordModal(
                                    controller: _controller,
                                    validator: isNotEmpty,
                                  ),
                                );
                              },
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: AppColors.fontColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.fontColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    FutureBlueButton(
                      onPressed: _controller.signInButtonPressed,
                      loader: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      text: 'Sign In',
                    ),
                    const SizedBox(height: 32),
                    SignUpButton(
                      onPressed: _controller.signUpButtonPressed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
