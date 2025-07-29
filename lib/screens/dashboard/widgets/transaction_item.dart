import 'package:flutter/material.dart';
import '../../../backends/models/transaction_models.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/app_styles.dart';

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
          color: const Color(0xFFEEEEEE), // grey[200] equivalent
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
                horizontal: AppSpacing.lg,
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
        size: 16.0,
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
            color: AppTheme.lightOnSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: AppSpacing.xxs),

        /// Subtitle and Time
        Text(
          _buildSubtitleWithTime(),
          style: AppTextStyles.bodySmall.copyWith(color: const Color(0xFF9E9E9E)), // grey[500] equivalent
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
        color: transaction.isIncome ? AppTheme.success : AppTheme.error,
      ),
    );
  }

  /// Builds a subtle divider between transactions
  Widget _buildDivider() {
    return Container(
      height: 1,
      color: const Color(0xFFE0E0E0), // grey[300] equivalent
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
      return AppTheme.success.withValues(alpha: 0.1);
    } else {
      return AppTheme.error.withValues(alpha: 0.1);
    }
  }

  /// Returns the color for the transaction icon
  Color _getIconColor() {
    if (transaction.isIncome) {
      return AppTheme.success;
    } else {
      return AppTheme.error;
    }
  }
}
