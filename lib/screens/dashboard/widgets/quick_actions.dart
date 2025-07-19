import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';

/// ============================= Quick Actions =============================
/// 
/// Quick action buttons for common tasks: Add Transaction and Pay Bill
/// UI-only implementation as per Step 4.1 requirements
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  /// ============================= Build Method =============================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Title
        Text(
          'Quick Actions',
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        
        SizedBox(height: AppSpacing.md),
        
        /// Action Buttons Row
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                context,
                'Add Transaction',
                Icons.add,
                AppColors.primary,
                () => _onAddTransaction(context),
              ),
            ),
            
            SizedBox(width: AppSpacing.md),
            
            Expanded(
              child: _buildActionButton(
                context,
                'Pay Bill',
                Icons.payment,
                AppColors.primaryMedium,
                () => _onPayBill(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// ============================= Helper Methods =============================

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {   
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.lg,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: AppColors.white,
                  size: AppSpacing.iconMedium,
                ),
                
                SizedBox(height: AppSpacing.sm),
                
                Text(
                  label,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ============================= Action Handlers =============================

  void _onAddTransaction(BuildContext context) {
    // Haptic feedback for better UX
    HapticFeedback.lightImpact();
    
    // Show placeholder dialog (UI-only implementation)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Transaction'),
        content: const Text('This feature will be implemented in later phases.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onPayBill(BuildContext context) {
    // Haptic feedback for better UX
    HapticFeedback.lightImpact();
    
    // Show placeholder dialog (UI-only implementation)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pay Bill'),
        content: const Text('This feature will be implemented in later phases.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}