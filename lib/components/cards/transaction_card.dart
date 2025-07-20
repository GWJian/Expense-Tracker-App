import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// ============================= Transaction Card =============================
///
/// Reusable card component for displaying transaction information
/// Used in recent transactions list and transaction history
class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.icon,
    required this.isIncome,
    this.onTap,
  });

  /// ============================= Properties =============================

  final String title; // Transaction title (e.g., "Grocery Store")
  final String subtitle; // Transaction subtitle (e.g., "Food & Dining")
  final double amount; // Transaction amount
  final String date; // Transaction date
  final IconData icon; // Transaction category icon
  final bool isIncome; // Whether this is income or expense
  final VoidCallback? onTap; // Callback for tap events

  /// ============================= Build Method =============================

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(AppSpacing.sm),
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        side: BorderSide(color: AppColors.grey200, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.cardPadding),
          child: Row(
            children: [
              /// Transaction Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getIconBackgroundColor(),
                  borderRadius: BorderRadius.circular(AppSpacing.md),
                ),
                child: Icon(
                  icon,
                  color: _getIconColor(),
                  size: AppSpacing.iconMedium,
                ),
              ),

              SizedBox(width: AppSpacing.md),

              /// Transaction Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Transaction Title
                    Text(
                      title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightOnSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: AppSpacing.xs),

                    /// Transaction Subtitle
                    Text(
                      subtitle,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.lightOnSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              SizedBox(width: AppSpacing.sm),

              /// Transaction Amount and Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// Transaction Amount
                  Text(
                    '${isIncome ? '+' : '-'}\$${amount.toStringAsFixed(2)}',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isIncome ? AppColors.success : AppColors.error,
                    ),
                  ),

                  SizedBox(height: AppSpacing.xxs),

                  /// Transaction Date
                  Text(
                    date,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ============================= Helper Methods =============================

  /// Returns the background color for the transaction icon
  Color _getIconBackgroundColor() {
    if (isIncome) {
      return AppColors.success.withValues(alpha: 0.1);
    } else {
      return AppColors.error.withValues(alpha: 0.1);
    }
  }

  /// Returns the color for the transaction icon
  Color _getIconColor() {
    if (isIncome) {
      return AppColors.success;
    } else {
      return AppColors.error;
    }
  }
}

/// ============================= Transaction Model =============================
///
/// Simple data model for transaction information
/// Used for hardcoded transaction data in UI-only phase
class TransactionData {
  const TransactionData({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.icon,
    required this.isIncome,
  });

  final String title;
  final String subtitle;
  final double amount;
  final String date;
  final IconData icon;
  final bool isIncome;
}
