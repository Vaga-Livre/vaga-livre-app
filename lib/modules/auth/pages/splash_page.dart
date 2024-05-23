import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../config/extension.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      asyncNavigationCallback: () async {
        final loggedIn = Supabase.instance.client.auth.currentSession != null;

        Future.delayed(Durations.extralong4).then((value) => context.go(loggedIn ? "/" : "/login"));
      },
      splashScreenBody: Container(
        color: context.colorScheme.primary,
        child: Center(
          child: Hero(
            tag: "splash-image-login",
            child: Image.asset(
              'assets/images/darker_expanded.png',
              height: 127,
              width: 104,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
