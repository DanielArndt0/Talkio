import 'package:talkio/controllers/NavigationController.dart';
import 'package:talkio/controllers/SignInController.dart';
import 'package:talkio/errors/AuthException.dart';
import 'package:talkio/services/AuthService.dart';
import 'package:talkio/services/CloudDBService.dart';

class SignInControllerImpl implements SignInController {
  SignInControllerImpl({
    required this.navigationController,
    required this.authService,
    required this.cloudDbService,
  });

  late final NavigationController navigationController;
  late final AuthService authService;
  late final CloudDBService cloudDbService;

  @override
  void loginWithPhoneButton() {}

  @override
  void loginWithTalkioButton() {
    navigationController.goToSignInSocial();
  }

  @override
  Future<void> loginWithGoogleButton() async {
    try {
      await authService.loginWithGoogle();
      await cloudDbService.createUser(
        name: authService.currentUser.displayName!,
        userID: authService.currentUser.uid,
        email: authService.currentUser.email!,
      );
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
