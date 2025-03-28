import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkio/NamedRoutes.dart';
import 'package:talkio/components/TalkioLogoAnimated.dart';
import 'package:talkio/providers/FbAuthProvider.dart';
import 'package:talkio/services/NavigationService.dart';

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
          child: TalkioLogoAnimated(
            duration: Duration(milliseconds: 100),
          ), // Ícone de carregamento
        ),
      );
    }

    return child;
  }
}
