import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkio/components/AppFormField.dart';
import 'package:talkio/components/FutureBlueButton.dart';
import 'package:talkio/components/SignInComponent.dart';
import 'package:talkio/components/TalkioLogo.dart';
import 'package:talkio/controllers/SignUpController.dart';
import 'package:talkio/validators/FormValidator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with FormValidator {
  late final SignUpController _controller;

  @override
  void initState() {
    _controller = context.read<SignUpController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(),
              const TalkioLogo(size: 40),
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
                  TalkioLogo(size: 18),
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
                          labelText: 'Enter your name',
                          hintText: 'John Marston',
                          controller: _controller.name,
                          keyboardType: TextInputType.name,
                          validator: isNotEmpty,
                        ),
                        const SizedBox(height: 18),
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
                        const SizedBox(height: 18),
                        AppFormField(
                          labelText: 'Confirm your password',
                          hintText: '••••••••',
                          controller: _controller.confirmedPassword,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (string) => combine(
                            [
                              () => isNotEmpty(string),
                              () => confirmPassword(
                                  string, _controller.password.text)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    FutureBlueButton(
                      text: 'Sign Up',
                      loader: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      onPressed: _controller.signUpButtonPressed,
                    ),
                    const SizedBox(height: 32),
                    SignInComponent(
                      onPressed: _controller.signInButtonPressed,
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
