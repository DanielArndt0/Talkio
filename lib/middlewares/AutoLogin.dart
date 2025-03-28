import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/NamedRoutes.dart';
import 'package:training_app/providers/FbAuthProvider.dart';
import 'package:training_app/services/NavigationService.dart';

class AutoLogin extends StatelessWidget {
  final Widget child;
  const AutoLogin({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<FbAuthProvider>(context);
    final navigationService = Provider.of<NavigationService>(context);

    if (authProvider.user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigationService.navigatePopAllTo(routeName: NamedRoutes.home);
      });
      return const Scaffold();
    }

    return child;
  }
}
