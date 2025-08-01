import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../theme/app_theme.dart';

/// ============================= Main Screen =============================
///
/// The main screen that integrates with go_router's StatefulShellRoute
/// and uses PersistentTabView.router for bottom navigation with state preservation.
class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.navigationShell,
  });

  /// ============================= Properties =============================

  final StatefulNavigationShell navigationShell;

  /// ============================= Methods =============================


  void _onAddPressed(BuildContext context) {
    // TODO: Navigate to add transaction screen
    // For now, show a placeholder dialog
    HapticFeedback.lightImpact();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Transaction'),
        content: const Text('This feature will be implemented soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// ============================= Build Method =============================

  @override
  Widget build(BuildContext context) {
    return PersistentTabView.router(
      tabs: [
        PersistentRouterTabConfig(
          item: ItemConfig(
            icon: const Icon(Icons.home_outlined),
            title: "Home",
            activeForegroundColor: AppTheme.primarySeed,
            inactiveForegroundColor: AppTheme.primaryMedium,
          ),
        ),
        PersistentRouterTabConfig(
          item: ItemConfig(
            icon: const Icon(Icons.bar_chart_outlined),
            title: "Statistics",
            activeForegroundColor: AppTheme.primarySeed,
            inactiveForegroundColor: AppTheme.primaryMedium,
          ),
        ),
        PersistentRouterTabConfig(
          item: ItemConfig(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            title: "Wallet",
            activeForegroundColor: AppTheme.primarySeed,
            inactiveForegroundColor: AppTheme.primaryMedium,
          ),
        ),
        PersistentRouterTabConfig(
          item: ItemConfig(
            icon: const Icon(Icons.person_outline),
            title: "Profile",
            activeForegroundColor: AppTheme.primarySeed,
            inactiveForegroundColor: AppTheme.primaryMedium,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
      ),
      navigationShell: navigationShell,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddPressed(context),
        shape: const StadiumBorder(),
        backgroundColor: AppTheme.primarySeed,
        foregroundColor: AppTheme.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
