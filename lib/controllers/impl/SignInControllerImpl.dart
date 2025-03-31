import 'package:talkio/controllers/NavigationController.dart';
import 'package:talkio/controllers/SignInController.dart';
import 'package:talkio/errors/AuthException.dart';
import 'package:talkio/services/AuthService.dart';
import 'package:talkio/services/CloudDBService.dart';
import 'package:talkio/services/MessagingService.dart';

class SignInControllerImpl implements SignInController {
  SignInControllerImpl({
    required this.navigationController,
    required this.authService,
    required this.cloudDbService,
    required this.messagingService,
  });

  late final NavigationController navigationController;
  late final AuthService authService;
  late final MessagingService messagingService;
  late final CloudDBService cloudDbService;

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
        tokenFCM: messagingService.token,
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
      //await authService.loginWithFacebook();
      throw UnimplementedError();
    } on AuthException catch (error) {
      navigationController.showSnackbar(message: error.message);
    } on UnimplementedError {
      navigationController.showSnackbar(message: "Unimplemented");
    } catch (error) {
      navigationController.showSnackbar(message: error.toString());
    }
  }

  @override
  void loginWithPhoneButton() {
    try {
      throw UnimplementedError();
    } on AuthException catch (error) {
      navigationController.showSnackbar(message: error.message);
    } on UnimplementedError {
      navigationController.showSnackbar(message: "Unimplemented");
    } catch (error) {
      navigationController.showSnackbar(message: error.toString());
    }
  }

  @override
  void signUpButton() {}
}
