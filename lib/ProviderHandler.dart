import 'package:provider/provider.dart';
import 'package:training_app/app/App.dart';
import 'package:training_app/controllers/HomeController.dart';
import 'package:training_app/controllers/NavigationController.dart';
import 'package:training_app/controllers/PrivateChatController.dart';
import 'package:training_app/controllers/SignInController.dart';
import 'package:training_app/controllers/SignInSocialController.dart';
import 'package:training_app/controllers/SignUpController.dart';
import 'package:training_app/controllers/impl/HomeControllerImpl.dart';
import 'package:training_app/controllers/impl/NavigationControllerImpl.dart';
import 'package:training_app/controllers/impl/PrivateCharControllerImpl.dart';
import 'package:training_app/controllers/impl/SignInControllerImpl.dart';
import 'package:training_app/controllers/impl/SignInSocialControllerImpl.dart';
import 'package:training_app/controllers/impl/SignUpControllerImpl.dart';
import 'package:training_app/providers/FbAuthProvider.dart';
import 'package:training_app/services/AuthService.dart';
import 'package:training_app/services/CloudDBService.dart';
import 'package:training_app/services/NavigationService.dart';
import 'package:training_app/services/impl/AuthServiceImpl.dart';
import 'package:training_app/services/impl/CloudDBServiceImpl.dart';
import 'package:training_app/services/impl/NavigationServiceImpl.dart';

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
