import 'package:flutter/material.dart';
import 'package:training_app/RouteHandler.dart';
import 'package:training_app/app/AppTheme.dart';
import 'package:training_app/services/impl/NavigationServiceImpl.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigator = GlobalKey();

  @override
  void initState() {
    NavigationServiceImpl.instance.navigator = _navigator;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talky.',
      theme: AppTheme.theme,
      routes: RouteHandler.routes,
      initialRoute: RouteHandler.initialRoute,
      navigatorKey: _navigator,
    );
  }
}
