import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_styles.dart';

/// ============================= Custom App Bar =============================
/// 
/// Custom app bar with personalized greeting and notification icon
/// Used across different screens for consistent branding
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.greeting,
    this.showNotifications = true,
    this.actions,
  });

  /// ============================= Properties =============================
  
  final String greeting;
  final bool showNotifications;
  final List<Widget>? actions;

  /// ============================= Build Method =============================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: AppTheme.white.withValues(alpha: 0.0),
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: actions ?? (showNotifications ? [
        IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: colorScheme.onSurfaceVariant,
          ),
          onPressed: () {
            // TODO: Navigate to notifications screen
            // Implementation note: This will require creating a notifications screen
            // and adding the route to app_router.dart when notifications feature is ready
          },
        ),
        SizedBox(width: AppSpacing.sm),
      ] : null),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}