import 'package:flutter/material.dart';
import 'package:vagalivre/config/extension.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: context.colorScheme.primary,
        child: Center(
          child: Image.asset('assets/images/darker.png'),
        ),
      ),
    );
  }
}
