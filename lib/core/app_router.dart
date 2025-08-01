import 'package:expense_tracker_app/screens/auth/login_screen.dart';
import 'package:expense_tracker_app/screens/main_screen.dart';
import 'package:expense_tracker_app/screens/dashboard/views/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// ============================= App Router =============================
///
/// Central router configuration using go_router for the entire application.
/// Provides declarative, URL-based navigation with deep linking support.
/// Uses StatefulShellRoute for persistent bottom navigation with state preservation.

// Global navigator keys for different sections
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _statisticsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'statistics');
final _walletNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'wallet');
final _profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    /// Authentication routes (outside the tab structure)
    GoRoute(
      path: '/',
      redirect: (context, state) => '/login',
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    /// Main application structure with persistent bottom navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        /// Home/Dashboard Tab
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const DashboardScreen(),
              routes: [
                // Add nested routes here for home section
                // Example: transaction details, etc.
              ],
            ),
          ],
        ),

        /// Statistics Tab
        StatefulShellBranch(
          navigatorKey: _statisticsNavigatorKey,
          routes: [
            GoRoute(
              path: '/statistics',
              builder: (context, state) => _buildPlaceholderScreen('Statistics'),
              routes: [
                // Add nested routes here for statistics section
              ],
            ),
          ],
        ),

        /// Wallet Tab
        StatefulShellBranch(
          navigatorKey: _walletNavigatorKey,
          routes: [
            GoRoute(
              path: '/wallet',
              builder: (context, state) => _buildPlaceholderScreen('Wallet'),
              routes: [
                // Add nested routes here for wallet section
              ],
            ),
          ],
        ),

        /// Profile Tab
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => _buildPlaceholderScreen('Profile'),
              routes: [
                // Add nested routes here for profile section
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

/// Helper function to create placeholder screens for tabs under development
Widget _buildPlaceholderScreen(String title) {
  return Builder(
    builder: (context) {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;

      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.construction_outlined,
                  size: 48.0,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16.0),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'This feature will be\nimplemented soon',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}