import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/app_styles.dart';

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
          colors: [AppTheme.primaryDark, AppTheme.primaryMedium],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.md),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primarySeed.withValues(alpha: 0.3),
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
              color: AppTheme.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: AppSpacing.xs),

          /// Balance Amount - Prominent display
          Text(
            '\$${_totalBalance.toStringAsFixed(2)}',
            style: AppTextStyles.displayLarge.copyWith(
              color: AppTheme.white,
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
                  AppTheme.primarySeed,
                ),
              ),

              SizedBox(width: AppSpacing.md),

              Expanded(
                child: _buildSummaryItem(
                  context,
                  'Expenses',
                  _monthlyExpenses,
                  Icons.arrow_downward,
                  AppTheme.primaryMedium,
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
        color: AppTheme.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 16.0),

          SizedBox(width: AppSpacing.xs),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppTheme.white.withValues(alpha: 0.8),
                  ),
                ),
                Text(
                  '\$${amount.toStringAsFixed(2)}',
                  style: AppTextStyles.balanceAmount.copyWith(color: AppTheme.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
