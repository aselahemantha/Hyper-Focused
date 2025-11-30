import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hyper_focused/features/auth/presentation/pages/login_page.dart';
import 'package:hyper_focused/features/auth/presentation/pages/signup_page.dart';
import 'package:hyper_focused/features/auth/presentation/controllers/auth_controller.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
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
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Home Page'))), // Placeholder for Home
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
