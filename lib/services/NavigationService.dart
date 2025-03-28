import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

abstract class NavigationService {
  Future navigateTo<T>({
    required String routeName,
    T? object,
    PageTransitionType? type,
  });

  Future navigatePopTo<T>({
    required String routeName,
    T? object,
  });

  Future navigatePopAllTo<T>({
    required String routeName,
    T? object,
  });

  void navigatePop();

  void showSnackbar({required String message});

  BuildContext? getContext();
}
