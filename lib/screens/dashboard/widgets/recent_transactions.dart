import 'package:flutter/material.dart';
import '../../../components/cards/transaction_card.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';

/// ============================= Recent Transactions =============================
/// 
/// Dashboard widget displaying a list of recent transactions
/// Implements Step 4.2: Recent Transactions from UI development guide
class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  /// ============================= Hardcoded Data =============================
  
  /// Static transaction data for UI-only phase
  static const List<TransactionData> _recentTransactions = [
    TransactionData(
      title: 'Salary Payment',
      subtitle: 'Monthly Salary',
      amount: 5250.00,
      date: 'Today',
      icon: Icons.account_balance_wallet,
      isIncome: true,
    ),
    TransactionData(
      title: 'Grocery Store',
      subtitle: 'Food & Dining',
      amount: 67.45,
      date: 'Yesterday',
      icon: Icons.shopping_cart,
      isIncome: false,
    ),
    TransactionData(
      title: 'Coffee Shop',
      subtitle: 'Food & Dining',
      amount: 12.50,
      date: 'Yesterday',
      icon: Icons.local_cafe,
      isIncome: false,
    ),
    TransactionData(
      title: 'Gas Station',
      subtitle: 'Transportation',
      amount: 45.20,
      date: '19/7/2025',
      icon: Icons.local_gas_station,
      isIncome: false,
    ),
    TransactionData(
      title: 'Freelance Project',
      subtitle: 'Additional Income',
      amount: 850.00,
      date: '18/7/2025',
      icon: Icons.work,
      isIncome: true,
    ),
    TransactionData(
      title: 'Netflix Subscription',
      subtitle: 'Entertainment',
      amount: 15.99,
      date: '17/7/2025',
      icon: Icons.play_circle_outline,
      isIncome: false,
    ),
  ];

  /// ============================= Build Method =============================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Header with View All Button
        _buildSectionHeader(context),
        
        /// Transaction List
        _buildTransactionList(),
      ],
    );
  }

  /// ============================= UI Building Methods =============================

  /// Builds the section header with title and View All button
  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Transactions',
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.lightOnSurface,
          ),
        ),
        
        TextButton(
          onPressed: () {
            /// Navigate to transaction history screen (UI only)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Transaction history coming soon!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.lg,
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'View All',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the list of transaction cards
  Widget _buildTransactionList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _recentTransactions.length,
      itemBuilder: (context, index) {
        final transaction = _recentTransactions[index];
        
        return TransactionCard(
          title: transaction.title,
          subtitle: transaction.subtitle,
          amount: transaction.amount,
          date: transaction.date,
          icon: transaction.icon,
          isIncome: transaction.isIncome,
          onTap: () {
            /// Navigate to transaction details screen (UI only)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Transaction details for ${transaction.title}'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        );
      },
    );
  }
}