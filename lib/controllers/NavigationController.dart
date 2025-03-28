
import 'package:talkio/models/ChatModel.dart';

abstract class NavigationController {
  Future goToSignInSocial();
  Future goToSignUp();
  Future goToProfile();
  Future goToHome();
  Future goToChat({required ChatModel chatData});
  void pop();
  void showSnackbar({required String message});
}