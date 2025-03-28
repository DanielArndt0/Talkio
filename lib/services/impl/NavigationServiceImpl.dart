import 'package:flutter/material.dart';
import 'package:talkio/services/NavigationService.dart';
import 'package:page_transition/page_transition.dart';

class NavigationServiceImpl implements NavigationService {
  NavigationServiceImpl._();
  static final NavigationServiceImpl instance = NavigationServiceImpl._();

  late final GlobalKey<NavigatorState> navigator;

  @override
  Future navigateTo<T>({
    required String routeName,
    T? object,
    PageTransitionType? type,
  }) async {
    if (type == null) {
      await navigator.currentState?.pushNamed(
        routeName,
        arguments: object,
      );
    } else {
      await navigator.currentState?.context.pushNamedTransition(
        routeName: routeName,
        type: type,
        arguments: object,
        duration: const Duration(milliseconds: 300)
      );
    }
  }

  @override
  Future navigatePopTo<T>({
    required String routeName,
    T? object,
  }) async {
    await navigator.currentState?.popAndPushNamed(routeName, arguments: object);
  }

  @override
  Future navigatePopAllTo<T>({required String routeName, T? object}) async {
    await navigator.currentState?.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: object);
  }

  @override
  void navigatePop() {
    navigator.currentState?.pop();
  }

  @override
  void showSnackbar({required String message}) {
    ScaffoldMessenger.of(navigator.currentContext!).showSnackBar(
      SnackBar(
        
        content: Text(message),
      ),
    );
  }

  @override
  BuildContext? getContext() => navigator.currentContext;
}
