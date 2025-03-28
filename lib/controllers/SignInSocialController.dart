import 'package:flutter/material.dart';

abstract class SignInSocialController {
  TextEditingController get email;
  TextEditingController get password;
  TextEditingController get forgotPassword;
  GlobalKey<FormState> get formKey;
  GlobalKey<FormState> get forgotPasswordFormKey;

  Future<void> signInButtonPressed();
  Future<void> signUpButtonPressed();
  Future<void> forgotPasswordButtonPressed();
}
