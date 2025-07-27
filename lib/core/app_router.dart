import 'package:expense_tracker_app/screens/auth/login_screen.dart';
import 'package:expense_tracker_app/screens/main_screen.dart';
import 'package:go_router/go_router.dart';


/// ============================= App Router =============================
///
/// Central router configuration using go_router for the entire application.
/// Provides declarative, URL-based navigation with deep linking support.
final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/login',
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainScreen(),
    ),
  ],
);