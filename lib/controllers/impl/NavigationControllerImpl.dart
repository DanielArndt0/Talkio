import 'package:page_transition/page_transition.dart';
import 'package:talkio/NamedRoutes.dart';
import 'package:talkio/controllers/NavigationController.dart';
import 'package:talkio/models/ChatModel.dart';
import 'package:talkio/services/NavigationService.dart';

class NavigationControllerImpl implements NavigationController {
  NavigationControllerImpl({
    required this.navigationService,
  });

  late final NavigationService navigationService;

  @override
  Future goToSignInSocial() async {
    await navigationService.navigateTo(
      routeName: NamedRoutes.signInSocial,
      type: PageTransitionType.topToBottom,
    );
  }

  @override
  Future goToSignUp() async {
    await navigationService.navigateTo(
      routeName: NamedRoutes.signUp,
      type: PageTransitionType.bottomToTop,
    );
  }

  @override
  Future goToProfile() async {
    await navigationService.navigatePopAllTo(routeName: NamedRoutes.profile);
  }

  @override
  void pop() {
    navigationService.navigatePop();
  }

  @override
  Future goToHome() async {
    await navigationService.navigatePopAllTo(routeName: NamedRoutes.home);
  }

  @override
  Future goToChat({required ChatModel chatData}) async {
    await navigationService.navigateTo<ChatModel>(
      routeName: NamedRoutes.privateChat,
      object: chatData,
      type: PageTransitionType.rightToLeft,
    );
  }

  @override
  void showSnackbar({required String message}) =>
      navigationService.showSnackbar(message: message);
}
