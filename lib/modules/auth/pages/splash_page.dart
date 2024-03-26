import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';

import '../../../config/extension.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      asyncNavigationCallback: () async {
        Future.delayed(Durations.extralong4).then((value) => Navigator.pushReplacementNamed(
              context,
              "login",
            ));
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
