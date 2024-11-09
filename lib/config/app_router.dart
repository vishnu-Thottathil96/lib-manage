import 'package:assesment_elt/features/Splash/screens/splash_screen.dart';
import 'package:assesment_elt/features/auth/screens/registration.dart';
import 'package:assesment_elt/features/books/screens/book_details.dart';
import 'package:assesment_elt/features/landing/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        path:
            '/bookDetail/:bookId/:starCount', // Include both bookId and starCount in the path
        builder: (context, state) {
          final bookId = state.pathParameters['bookId']!;
          final starCount = state.pathParameters['starCount']!;
          return BookDetailScreen(
            bookId: bookId,
            starCount: starCount,
          );
        },
      ),
    ],
  );

  // Helper methods for navigation
  void goToRegister(BuildContext context) => context.go('/register');
  void goToLanding(BuildContext context) => context.go('/landing');

  // Updated method to include both bookId and starCount as parameters
  void goToBookDetail(BuildContext context, String bookId, String starCount) {
    context.go('/bookDetail/$bookId/$starCount');
  }
}
