import 'package:flutter/material.dart';

abstract class SignUpController {
  TextEditingController get password;
  TextEditingController get confirmedPassword;
  TextEditingController get email;
  TextEditingController get name;
  GlobalKey<FormState> get formKey;

  void signInButtonPressed();
  Future<void> signUpButtonPressed();
}