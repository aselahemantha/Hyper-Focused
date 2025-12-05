import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hyper_focused/features/auth/presentation/pages/login_page.dart';
import 'package:hyper_focused/features/auth/presentation/pages/signup_page.dart';
import 'package:hyper_focused/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hyper_focused/features/home/presentation/pages/home_page.dart';
import 'package:hyper_focused/features/plan/presentation/pages/plan_page.dart';
import 'package:hyper_focused/features/check/presentation/pages/check_page.dart';
import 'package:hyper_focused/features/approved/presentation/pages/approved_page.dart';
import 'package:hyper_focused/features/settings/presentation/pages/settings_page.dart';
import 'package:hyper_focused/core/presentation/widgets/bottom_nav_bar.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final authState = ref.watch(authControllerProvider);
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: BottomNavBar(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/plan',
                builder: (context, state) => const PlanPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/check',
                builder: (context, state) => const CheckPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/approved',
                builder: (context, state) => const ApprovedPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isLoggingIn = state.uri.path == '/login';
      final isSigningUp = state.uri.path == '/signup';

      if (!isLoggedIn && !isLoggingIn && !isSigningUp) {
        return '/login';
      }

      if (isLoggedIn && (isLoggingIn || isSigningUp)) {
        return '/';
      }

      return null;
    },
  );
}
