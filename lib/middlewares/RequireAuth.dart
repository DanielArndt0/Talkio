import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/NamedRoutes.dart';
import 'package:training_app/components/TalkyLogoAnimated.dart';
import 'package:training_app/providers/FbAuthProvider.dart';
import 'package:training_app/services/NavigationService.dart';

class RequireAuth extends StatelessWidget {
  final Widget child;

  const RequireAuth({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<FbAuthProvider>(context);
    final navigationService = Provider.of<NavigationService>(context);

    if (authProvider.user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(
          const Duration(seconds: 1),
          () =>
              navigationService.navigatePopAllTo(routeName: NamedRoutes.signIn),
        );
      });
      return const Scaffold(
        body: Center(
          child: TalkyLogoAnimated(
            duration: Duration(milliseconds: 100),
          ), // Ícone de carregamento
        ),
      );
    }

    return child;
  }
}
