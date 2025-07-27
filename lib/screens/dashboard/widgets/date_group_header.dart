import 'package:flutter/material.dart';
import '../../../backends/models/transaction_models.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';

/// ============================= Date Group Header =============================
///
/// Full-width header widget for grouping transactions by date
/// Features gray background with date on left and total amount on right
class DateGroupHeader extends StatelessWidget {
  const DateGroupHeader({
    super.key,
    required this.group,
  });

  /// ============================= Properties =============================

  final TransactionGroup group; // Transaction group data

  /// ============================= Build Method =============================

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.xs,
      ),
      decoration: const BoxDecoration(
        color: AppColors.grey300,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Date Section
          _buildDateSection(),
          
          /// Amount Section
          _buildAmountSection(),
        ],
      ),
    );
  }

  /// ============================= UI Building Methods =============================

  /// Builds the left side with date and transaction count
  Widget _buildDateSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Date Text
          Text(
            group.displayDate,
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryDark,
            ),
          ),
          
          /// Transaction Count (if expanded or more than one transaction)
          if (group.transactionCount > 1)
            Text(
              '${group.transactionCount} transactions',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.grey600,
              ),
            ),
        ],
      ),
    );
  }

  /// Builds the right side with total amount
  Widget _buildAmountSection() {
    return Text(
      group.formattedTotal,
      style: AppTextStyles.titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        color: _getAmountColor(),
      ),
    );
  }

  /// ============================= Helper Methods =============================

  /// Returns the appropriate color for the amount based on positive/negative value
  Color _getAmountColor() {
    if (group.isPositiveDay) {
      return AppColors.success;
    } else {
      return AppColors.error;
    }
  }
}