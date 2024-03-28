import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:vagalivre/modules/auth/pages/login_page.dart';
import 'package:vagalivre/modules/auth/pages/register_user_info_page.dart';
import 'package:vagalivre/modules/home/pages/home_page.dart';
import 'package:vagalivre/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  initializeDateFormatting('pt_BR', null);

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
      theme: MaterialTheme(ThemeData.light().textTheme).light(),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "login": (context) => const LoginPage(),
        "PersonalInformation": (context) => RegisterUserInfoPage(),
      },
    );
  }
}
