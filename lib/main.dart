import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'modules/auth/pages/login_page.dart';
import 'modules/auth/pages/register_user_info_page.dart';
import 'modules/auth/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await initializeDateFormatting('pt_BR', null);

  await Supabase.initialize(
    url: FlutterConfig.get('PUBLIC_SUPABASE_URL'),
    anonKey: FlutterConfig.get('PUBLIC_SUPABASE_ANON_KEY'),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "splash",
      onGenerateRoute: (settings) {
        return switch (settings.name) {
          "splash" => MaterialPageRoute(builder: (_) => const SplashPage()),
          "PersonalInformation" => MaterialPageRoute(builder: (context) => const RegisterUserInfoPage()),
          "login" => PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginPage(),
              transitionDuration: Durations.medium4,
              reverseTransitionDuration: Durations.medium4,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 0.8);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          _ => MaterialPageRoute(builder: (context) => const LoginPage()),
        };
      },
    );
  }
}
