import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'modules/auth/pages/login_page.dart';
import 'modules/auth/pages/register_user_info_page.dart';
import 'modules/home/pages/home_page.dart';
import 'modules/home/pages/search_results_page.dart';
import 'modules/parks/controllers/parks_search_controller.dart';
import 'theme.dart';

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
    return ChangeNotifierProvider(
      create: (_) => ParksSearchController(
          queryTextController: TextEditingController(text: ""), searchInputFocusNode: FocusNode()),
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: MaterialTheme(ThemeData.light().textTheme).light(),
      ),
    );
  }
}

final _router = GoRouter(initialLocation: "/", routes: [
  GoRoute(
    path: "/",
    name: "home",
    builder: (_, __) => const HomePage(),
    routes: [
      GoRoute(
          path: "search-results",
          name: "search-results",
          builder: (context, _) => SearchResultsPage.builder(context))
    ],
  ),
  GoRoute(path: "/user/history", name: "history", builder: (_, state) => Container()),
  GoRoute(path: "/park/:id", name: "park-info", builder: (_, state) => Container()),
  GoRoute(path: "/login", builder: (_, __) => const LoginPage()),
  GoRoute(path: "/user-info", builder: (_, __) => const RegisterUserInfoPage()),
]);
