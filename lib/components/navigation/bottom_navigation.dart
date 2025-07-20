import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_spacing.dart';

/// ============================= Bottom Navigation =============================
/// 
/// Custom bottom navigation using BottomAppBar with curved notch
/// Features a notched design for FloatingActionButton integration
class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  /// ============================= Properties =============================
  
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  /// ============================= Build Method =============================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return BottomAppBar(
      // Create curved notch for FAB
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        StadiumBorder(), // Use for matching FAB shape
      ),
      notchMargin: 6.0,
      clipBehavior: Clip.antiAlias,
      color: colorScheme.surface,
      elevation: 8.0,
      height: 80,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home
            _buildNavItem(
              context,
              icon: Icons.home_outlined,
              activeIcon: Icons.home_filled,
              label: 'Home',
              isSelected: selectedIndex == 0,
              onTap: () => onItemTapped(0),
            ),
            // Statistics  
            _buildNavItem(
              context,
              icon: Icons.bar_chart_outlined,
              activeIcon: Icons.bar_chart,
              label: 'Statistics',
              isSelected: selectedIndex == 1,
              onTap: () => onItemTapped(1),
            ),
            // Empty space for FAB (automatically handled by BottomAppBar notch)
            const SizedBox(width: 48),
            // Wallet
            _buildNavItem(
              context,
              icon: Icons.account_balance_wallet_outlined,
              activeIcon: Icons.account_balance_wallet,
              label: 'Wallet',
              isSelected: selectedIndex == 2,
              onTap: () => onItemTapped(2),
            ),
            // Profile
            _buildNavItem(
              context,
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: 'Profile',
              isSelected: selectedIndex == 3,
              onTap: () => onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }

  /// ============================= Helper Methods =============================

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? activeIcon : icon,
                  color: isSelected ? AppColors.primary : colorScheme.onSurfaceVariant,
                  size: 20, // Smaller icon for better fit
                ),
                const SizedBox(height: 2), // Minimal spacing
                Flexible(
                  child: Text(
                    label,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: isSelected ? AppColors.primary : colorScheme.onSurfaceVariant,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 10, // Smaller text
                      height: 1.0, // Tight line height
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis, // prevent text overflow
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}