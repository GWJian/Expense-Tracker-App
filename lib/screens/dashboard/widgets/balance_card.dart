import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';

/// ============================= Balance Card =============================
///
/// Displays the user's total balance prominently with income/expense summary
/// Uses static amounts as per Step 4.1 requirements
class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  /// ============================= Static Data =============================

  // Hardcoded values as per UI development guide requirements
  static const double _totalBalance = 12450.75;
  static const double _monthlyIncome = 5200.00;
  static const double _monthlyExpenses = 3180.25;

  /// ============================= Build Method =============================

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryDark, AppColors.primaryMedium],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Balance Label
          Text(
            'Total Balance',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: AppSpacing.xs),

          /// Balance Amount - Prominent display
          Text(
            '\$${_totalBalance.toStringAsFixed(2)}',
            style: AppTextStyles.displayLarge.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: AppSpacing.md),

          /// Income/Expense Summary
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  context,
                  'Income',
                  _monthlyIncome,
                  Icons.arrow_upward,
                  AppColors.primary,
                ),
              ),

              SizedBox(width: AppSpacing.md),

              Expanded(
                child: _buildSummaryItem(
                  context,
                  'Expenses',
                  _monthlyExpenses,
                  Icons.arrow_downward,
                  AppColors.primaryMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ============================= Helper Methods =============================

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    double amount,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: AppSpacing.iconSmall),

          SizedBox(width: AppSpacing.xs),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                  ),
                ),
                Text(
                  '\$${amount.toStringAsFixed(2)}',
                  style: AppTextStyles.price.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
