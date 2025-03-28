import 'package:training_app/controllers/NavigationController.dart';
import 'package:training_app/controllers/SignInController.dart';
import 'package:training_app/errors/AuthException.dart';
import 'package:training_app/services/AuthService.dart';

class SignInControllerImpl implements SignInController {
  SignInControllerImpl({
    required this.navigationController,
    required this.authService,
  });

  late final NavigationController navigationController;
  late final AuthService authService;

  @override
  void loginWithPhoneButton() {}

  @override
  void loginWithTalkyButton() {
    navigationController.goToSignInSocial();
  }

  @override
  Future<void> loginWithGoogleButton() async {
    try {
      await authService.loginWithGoogle();
      navigationController.goToHome();
    } on AuthException catch (error) {
      navigationController.showSnackbar(message: error.message);
    } catch (error) {
      navigationController.showSnackbar(message: error.toString());
    }
  }

  @override
  Future<void> loginWithFacebookButton() async {
    try {
      await authService.loginWithFacebook();
    } on AuthException catch (error) {
      navigationController.showSnackbar(message: error.message);
    } catch (error) {
      navigationController.showSnackbar(message: 'Service unavailable');
    }
  }

  @override
  void signUpButton() {}
}
