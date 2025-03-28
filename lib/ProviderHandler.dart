import 'package:provider/provider.dart';
import 'package:talkio/app/App.dart';
import 'package:talkio/controllers/HomeController.dart';
import 'package:talkio/controllers/NavigationController.dart';
import 'package:talkio/controllers/PrivateChatController.dart';
import 'package:talkio/controllers/SignInController.dart';
import 'package:talkio/controllers/SignInSocialController.dart';
import 'package:talkio/controllers/SignUpController.dart';
import 'package:talkio/controllers/impl/HomeControllerImpl.dart';
import 'package:talkio/controllers/impl/NavigationControllerImpl.dart';
import 'package:talkio/controllers/impl/PrivateCharControllerImpl.dart';
import 'package:talkio/controllers/impl/SignInControllerImpl.dart';
import 'package:talkio/controllers/impl/SignInSocialControllerImpl.dart';
import 'package:talkio/controllers/impl/SignUpControllerImpl.dart';
import 'package:talkio/providers/FbAuthProvider.dart';
import 'package:talkio/services/AuthService.dart';
import 'package:talkio/services/CloudDBService.dart';
import 'package:talkio/services/NavigationService.dart';
import 'package:talkio/services/impl/AuthServiceImpl.dart';
import 'package:talkio/services/impl/CloudDBServiceImpl.dart';
import 'package:talkio/services/impl/NavigationServiceImpl.dart';

MultiProvider providerHandler = MultiProvider(
  providers: [
    ChangeNotifierProvider<FbAuthProvider>(
      create: (context) => FbAuthProvider(),
    ),
    Provider<NavigationService>(
      create: (context) => NavigationServiceImpl.instance,
    ),
    Provider<CloudDBService>(
      create: (context) => CloudDBServiceImpl.instance,
    ),
    ProxyProvider<FbAuthProvider, AuthService>(
      update: (
        context,
        authProvider,
        previous,
      ) =>
          AuthServiceImpl(
        authProvider: authProvider,
      ),
    ),
    ProxyProvider<NavigationService, NavigationController>(
      update: (
        context,
        navigationService,
        previous,
      ) =>
          NavigationControllerImpl(
        navigationService: navigationService,
      ),
    ),
    ProxyProvider2<AuthService, NavigationController, SignInSocialController>(
      update: (
        context,
        authService,
        navigationController,
        previous,
      ) =>
          SignInSocialControllerImpl(
        authService: authService,
        navigationController: navigationController,
      ),
    ),
    ProxyProvider2<AuthService, NavigationController, SignInController>(
      update: (context, authService, navigationController, previous) =>
          SignInControllerImpl(
        authService: authService,
        navigationController: navigationController,
      ),
    ),
    ProxyProvider3<AuthService, CloudDBService, NavigationController,
        HomeController>(
      update: (
        context,
        authService,
        cloudDbService,
        navigationController,
        previous,
      ) =>
          HomeControllerImpl(
        authService: authService,
        cloudDbService: cloudDbService,
        navigationController: navigationController,
      ),
    ),
    ProxyProvider3<AuthService, CloudDBService, NavigationController,
        SignUpController>(
      update: (
        context,
        authService,
        cloudDbService,
        navigationController,
        previous,
      ) =>
          SignUpControllerImpl(
        authService: authService,
        cloudDbService: cloudDbService,
        navigationController: navigationController,
      ),
    ),
    ProxyProvider3<AuthService, CloudDBService, NavigationController,
        PrivateChatController>(
      update: (
        context,
        authService,
        cloudDbService,
        navigationController,
        previous,
      ) =>
          PrivateChatControllerImpl(
        authService: authService,
        cloudDbService: cloudDbService,
        navigationController: navigationController,
      ),
    ),
  ],
  child: const MyApp(),
);
