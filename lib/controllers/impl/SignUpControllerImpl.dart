import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:talkio/Global.dart';
import 'package:talkio/controllers/NavigationController.dart';
import 'package:talkio/controllers/SignUpController.dart';
import 'package:talkio/errors/AuthException.dart';
import 'package:talkio/services/AuthService.dart';
import 'package:talkio/services/CloudDBService.dart';

class SignUpControllerImpl implements SignUpController {
  SignUpControllerImpl({
    required this.authService,
    required this.cloudDbService,
    required this.navigationController,
  });
  final AuthService authService;
  final CloudDBService cloudDbService;
  final NavigationController navigationController;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmedPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  TextEditingController get email => _email;

  @override
  TextEditingController get name => _name;

  @override
  TextEditingController get confirmedPassword => _confirmedPassword;

  @override
  TextEditingController get password => _password;

  @override
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void signInButtonPressed() {
    navigationController.pop();
  }

  @override
  Future<void> signUpButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      try {
        await authService.register(
          email: email.text,
          password: password.text,
        );

        await cloudDbService.createUser(
          name: name.text,
          email: email.text,
          userID: authService.currentUser.uid,
          tokenFCM: tokenFCM,
        );

        navigationController.goToHome();
      } on AuthException catch (error) {
        navigationController.showSnackbar(message: error.message);
      } catch (error) {
        navigationController.showSnackbar(message: error.toString());
      }
    }
  }
}
