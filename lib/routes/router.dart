import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../modules/auth/pages/login_page.dart';
import '../modules/auth/pages/register_user_info_page.dart';
import '../modules/auth/pages/splash_page.dart';
import '../modules/home/models/park_result.dart';
import '../modules/home/pages/search_results_page.dart';
import 'main_layout.dart';
import '../modules/park/pages/park_page.dart';

final router = GoRouter(initialLocation: "/splash", routes: [
  GoRoute(
    path: "/",
    name: "home",
    builder: (_, __) => const MainLayout(initialTabIndex: 0),
    routes: [
      GoRoute(
        path: "search-results",
        builder: (_, __) => const SearchResultsPage(),
      )
    ],
  ),
  GoRoute(
    path: "/user/reservations",
    name: "reservations",
    builder: (_, state) => const MainLayout(initialTabIndex: 1),
  ),
  GoRoute(
    path: "/park",
    builder: (_, state) => ParkPage(
      park: state.extra as ParkResult,
    ),
  ),
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
