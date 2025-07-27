import 'package:flutter/material.dart';
import '../../../backends/models/transaction_models.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';

/// ============================= Transaction Item =============================
///
/// Simplified transaction widget for use within grouped transaction lists
/// More compact than TransactionCard, designed for grouped display
class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    this.onTap,
    this.showDivider = true,
  });

  /// ============================= Properties =============================

  final TransactionData transaction; // Transaction data
  final VoidCallback? onTap; // Callback for tap events
  final bool showDivider; // Whether to show bottom divider

  /// ============================= Build Method =============================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: AppColors.grey200,
          elevation: 2,
          margin: EdgeInsets.all(AppSpacing.sm),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
                  /// Transaction Icon
                  _buildTransactionIcon(),

                  SizedBox(width: AppSpacing.md),

                  /// Transaction Details
                  Expanded(child: _buildTransactionDetails()),

                  SizedBox(width: AppSpacing.sm),

                  /// Transaction Amount
                  _buildTransactionAmount(),
                ],
              ),
            ),
          ),
        ),
        
        /// Divider
        if (showDivider) _buildDivider(),
      ],
    );
  }

  /// ============================= UI Building Methods =============================

  /// Builds the transaction icon with colored background
  Widget _buildTransactionIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: _getIconBackgroundColor(),
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Icon(
        transaction.icon,
        color: _getIconColor(),
        size: AppSpacing.iconSmall,
      ),
    );
  }

  /// Builds the transaction title, subtitle and time
  Widget _buildTransactionDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Transaction Title
        Text(
          transaction.title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.lightOnSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: AppSpacing.xxs),

        /// Subtitle and Time
        Text(
          _buildSubtitleWithTime(),
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.grey500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  /// Builds the transaction amount
  Widget _buildTransactionAmount() {
    return Text(
      _getFormattedAmount(),
      style: AppTextStyles.titleMedium.copyWith(
        fontWeight: FontWeight.w700,
        color: transaction.isIncome ? AppColors.success : AppColors.error,
      ),
    );
  }

  /// Builds a subtle divider between transactions
  Widget _buildDivider() {
    return Container(
      height: 1,
      color: AppColors.grey300,
    );
  }

  /// ============================= Helper Methods =============================

  /// Returns the subtitle with time if available
  String _buildSubtitleWithTime() {
    if (transaction.time != null) {
      return '${transaction.subtitle} • ${transaction.time}';
    }
    return transaction.subtitle;
  }

  /// Returns formatted amount with RM currency
  String _getFormattedAmount() {
    final prefix = transaction.isIncome ? '+' : '-';
    return '${prefix}RM${transaction.amount.toStringAsFixed(2)}';
  }

  /// Returns the background color for the transaction icon
  Color _getIconBackgroundColor() {
    if (transaction.isIncome) {
      return AppColors.success.withValues(alpha: 0.1);
    } else {
      return AppColors.error.withValues(alpha: 0.1);
    }
  }

  /// Returns the color for the transaction icon
  Color _getIconColor() {
    if (transaction.isIncome) {
      return AppColors.success;
    } else {
      return AppColors.error;
    }
  }
}
