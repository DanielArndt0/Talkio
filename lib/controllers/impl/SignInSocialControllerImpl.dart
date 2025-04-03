import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:talkio/Global.dart';
import 'package:talkio/controllers/NavigationController.dart';
import 'package:talkio/controllers/SignInSocialController.dart';
import 'package:talkio/errors/AuthException.dart';
import 'package:talkio/services/AuthService.dart';
import 'package:talkio/services/CloudDBService.dart';

class SignInSocialControllerImpl implements SignInSocialController {
  SignInSocialControllerImpl({
    required this.authService,
    required this.navigationController,
    required this.cloudDbService,
  });

  late final AuthService authService;
  late final CloudDBService cloudDbService;
  late final NavigationController navigationController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _forgotPassword = TextEditingController();

  @override
  GlobalKey<FormState> get formKey => _formKey;

  @override
  GlobalKey<FormState> get forgotPasswordFormKey => _forgotPasswordFormKey;

  @override
  TextEditingController get email => _email;

  @override
  TextEditingController get password => _password;

  @override
  TextEditingController get forgotPassword => _forgotPassword;

  @override
  Future<void> forgotPasswordButtonPressed() async {
    if (forgotPasswordFormKey.currentState!.validate()) {
      try {
        await authService.passwordRecovery(email: forgotPassword.text);
        navigationController.pop();
      } on AuthException catch (error) {
        navigationController.showSnackbar(message: error.message);
      } catch (error) {
        navigationController.showSnackbar(message: error.toString());
      }
    }
  }

  @override
  Future<void> signInButtonPressed() async {
    if (formKey.currentState!.validate()) {
      try {
        await authService.login(email: email.text, password: password.text);

        await cloudDbService.updateTokenFCM(
          userId: authService.currentUser.uid,
          token: tokenFCM,
        );

        navigationController.goToHome();
      } on AuthException catch (error) {
        navigationController.showSnackbar(message: error.message);
      } catch (error) {
        navigationController.showSnackbar(message: error.toString());
      }
    }
  }

  @override
  Future<void> signUpButtonPressed() async =>
      await navigationController.goToSignUp();
}
