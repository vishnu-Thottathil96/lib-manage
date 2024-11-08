import 'package:assesment_elt/features/Splash/screens/splash_screen.dart';
import 'package:assesment_elt/features/auth/screens/registration.dart';
import 'package:assesment_elt/features/books/screens/book_details.dart';
import 'package:assesment_elt/features/landing/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// AppRouter for modular navigation setup
class AppRouter {
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;
  AppRouter._internal();

  final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegistrationPage(),
      ),
      GoRoute(
        path: '/landing',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/bookDetail',
        builder: (context, state) => const BookDetailScreen(),
      ),
    ],
  );

  // Helper methods for navigation
  void goToRegister(BuildContext context) => context.go('/register');
  void goToLanding(BuildContext context) => context.go('/landing');
  void goToBookDetail(BuildContext context) => context.go('/bookDetail');
}
