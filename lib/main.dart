import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'modules/auth/pages/login_page.dart';
import 'modules/auth/pages/register_user_info_page.dart';
import 'modules/auth/pages/splash_page.dart';
import 'modules/home/controllers/map_controller.dart';
import 'modules/home/controllers/parks_search_controller.dart';
import 'modules/home/pages/home_page.dart';
import 'modules/home/pages/search_results_page.dart';
import 'modules/park/park_page.dart';
import 'theme.dart';
import 'utils/enviroment.dart';
import 'utils/object_box.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Environment.initialize();
  await initializeDateFormatting('pt_BR', null);

  await Supabase.initialize(
    url: Environment.get('PUBLIC_SUPABASE_URL'),
    anonKey: Environment.get('PUBLIC_SUPABASE_ANON_KEY'),
  );

  await ObjectBox.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: MaterialTheme(ThemeData.light().textTheme).light(),
    );
  }
}

final _router = GoRouter(initialLocation: "/splash", routes: [
  GoRoute(
    path: "/",
    name: "home",
    builder: (_, __) => const HomePage(),
    routes: [
      GoRoute(
        path: "search-results",
        builder: (_, __) => const SearchResultsPage(),
      )
    ],
  ),
  GoRoute(path: "/user/history", name: "history", builder: (_, state) => Container()),
  GoRoute(
      path: "/park",
      builder: (_, state) => ParkPage(
            park: state.extra as ParkResult,
          )),
  GoRoute(
      path: "/login",
      builder: (_, __) => const LoginPage(),
      pageBuilder: (context, state) => CustomTransitionPage(
            child: const LoginPage(),
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
          )),
  GoRoute(path: "/user-info", builder: (_, __) => const RegisterUserInfoPage()),
  GoRoute(path: "/splash", builder: (_, __) => const SplashPage()),
]);
