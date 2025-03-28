import 'package:flutter/material.dart';
import 'package:training_app/NamedRoutes.dart';
import 'package:training_app/middlewares/AutoLogin.dart';
import 'package:training_app/middlewares/RequireAuth.dart';
import 'package:training_app/models/ChatModel.dart';
import 'package:training_app/screens/HomeScreen.dart';
import 'package:training_app/screens/PrivateChatScreen.dart';
import 'package:training_app/screens/SignInScreen.dart';
import 'package:training_app/screens/SignInSocialScreen.dart';
import 'package:training_app/screens/SignUpProfileScreen.dart';
import 'package:training_app/screens/SignUpScreen.dart';

class RouteHandler {
  static final routes = {
    NamedRoutes.home: (context) => const RequireAuth(child: HomeScreen()),
    NamedRoutes.profile: (context) =>
        const RequireAuth(child: SignUpProfileScreen()),
    NamedRoutes.privateChat: (context) => RequireAuth(
          child: _openPage<ChatModel>(
            context,
            (chat) => PrivateChatScreen(chat: chat),
          ),
        ),
    NamedRoutes.signIn: (context) => const AutoLogin(child: SignInScreen()),
    NamedRoutes.signInSocial: (context) => const SignInSocialScreen(),
    NamedRoutes.signUp: (context) => const SignUpScreen(),
  };

  static const initialRoute = NamedRoutes.signIn;

  static Widget _openPage<T>(BuildContext context, Widget Function(T) onPage) {
    final args = ModalRoute.of(context)!.settings.arguments as T;
    return onPage(args);
  }
}
