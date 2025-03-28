import 'package:flutter/material.dart';
import 'package:talkio/NamedRoutes.dart';
import 'package:talkio/middlewares/AutoLogin.dart';
import 'package:talkio/middlewares/RequireAuth.dart';
import 'package:talkio/models/ChatModel.dart';
import 'package:talkio/screens/HomeScreen.dart';
import 'package:talkio/screens/PrivateChatScreen.dart';
import 'package:talkio/screens/SignInScreen.dart';
import 'package:talkio/screens/SignInSocialScreen.dart';
import 'package:talkio/screens/SignUpProfileScreen.dart';
import 'package:talkio/screens/SignUpScreen.dart';

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
