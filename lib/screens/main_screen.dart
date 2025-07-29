import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dashboard/views/dashboard_screen.dart';
import '../components/navigation/bottom_navigation.dart';
import '../theme/app_styles.dart';

/// ============================= Main Screen =============================
///
/// The main screen that contains the bottom navigation and manages
/// the different tab screens (Home, Statistics, Wallet, Profile)
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// ============================= Properties =============================

  int _selectedIndex = 0;

  /// ============================= Methods =============================

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Haptic feedback for better UX
    HapticFeedback.lightImpact();
  }

  void _onAddPressed() {
    // TODO: Navigate to add transaction screen
    HapticFeedback.lightImpact();
  }

  /// List of screens for each tab
  List<Widget> get _screens => [
    const DashboardScreen(),
    _buildPlaceholderScreen('Statistics'),
    _buildPlaceholderScreen('Wallet'),
    _buildPlaceholderScreen('Profile'),
  ];

  /// ============================= Build Method =============================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        shape: const StadiumBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  /// ============================= Helper Methods =============================

  /// Creates a placeholder screen with consistent styling
  Widget _buildPlaceholderScreen(String title) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Container(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.construction_outlined,
                  size: 48.0,
                  color: colorScheme.onSurfaceVariant,
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  title,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'This feature will be\nimplemented soon',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
