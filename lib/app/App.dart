import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkio/RouteHandler.dart';
import 'package:talkio/app/AppTheme.dart';
import 'package:talkio/services/MessagingService.dart';
import 'package:talkio/services/NavigationService.dart';
import 'package:talkio/services/NotificationService.dart';
import 'package:talkio/services/impl/NavigationServiceImpl.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigator = GlobalKey();
  //late final NavigationService _navigationService;
  late final NotificationService _notificationService;
  late final MessagingService _messagingService;

  @override
  void initState() {
    //_navigationService = context.read<NavigationService>();
    //_navigationService.
    NavigationServiceImpl.instance.navigator = _navigator;

    _notificationService = context.read<NotificationService>();
    _notificationService.initialize();

    _messagingService = context.read<MessagingService>();
    _messagingService.initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talkio.',
      theme: AppTheme.theme,
      routes: RouteHandler.routes,
      initialRoute: RouteHandler.initialRoute,
      navigatorKey: _navigator,
    );
  }
}
