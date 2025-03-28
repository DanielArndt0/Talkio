import 'package:flutter/material.dart';
import 'package:training_app/app/AppColors.dart';
import 'package:training_app/components/AppFormField.dart';
import 'package:training_app/components/FutureBlueButton.dart';
import 'package:training_app/components/TalkyLogo.dart';
import 'package:training_app/controllers/SignInSocialController.dart';

class ForgotPasswordModal extends StatelessWidget {
  final SignInSocialController controller;
  final String? Function(String?)? validator;

  const ForgotPasswordModal({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 28),
        child: Form(
          key: controller.forgotPasswordFormKey,
          child: Column(
            children: [
              const Row(),
              const TalkyLogo(size: 40),
              const SizedBox(height: 18),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Forgot your password?',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.fontColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              AppFormField(
                labelText: 'Enter your e-mail',
                hintText: 'example@email.com',
                controller: controller.forgotPassword,
                keyboardType: TextInputType.emailAddress,
                validator: validator,
              ),
              const SizedBox(height: 38),
              FutureBlueButton(
                onPressed: controller.forgotPasswordButtonPressed,
                loader: const CircularProgressIndicator(
                  color: Colors.white,
                ),
                text: 'Send Recovery Link',
              )
            ],
          ),
        ),
      ),
    );
  }
}
