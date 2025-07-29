import 'package:flutter/material.dart';
import '../../../backends/models/transaction_models.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/app_styles.dart';
import 'date_group_header.dart';
import 'transaction_item.dart';

/// ============================= Recent Transactions =============================
/// 
/// Dashboard widget displaying a list of recent transactions grouped by date
/// Features expandable date groups with daily totals and RM currency formatting
/// Implements modern UI patterns with full-width gray headers
class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {

  /// ============================= State & Data =============================
  
  /// List of transaction groups with expansion state
  late List<TransactionGroup> _transactionGroups;

  /// Static transaction data for UI-only phase with enhanced data
  static const List<TransactionData> _recentTransactions = [
    TransactionData(
      title: 'Salary Payment',
      subtitle: 'Monthly Salary',
      amount: 5250.00,
      date: 'Today',
      time: '9:00 AM',
      icon: Icons.account_balance_wallet,
      isIncome: true,
    ),
    TransactionData(
      title: 'Coffee Shop',
      subtitle: 'Food & Dining',
      amount: 67.45,
      date: 'Today',
      time: '2:30 PM',
      icon: Icons.local_cafe,
      isIncome: false,
    ),
    TransactionData(
      title: 'Grocery Store',
      subtitle: 'Food & Dining',
      amount: 67.45,
      date: 'Yesterday',
      time: '11:15 AM',
      icon: Icons.shopping_cart,
      isIncome: false,
    ),
    TransactionData(
      title: 'Coffee Shop',
      subtitle: 'Food & Dining',
      amount: 12.50,
      date: 'Yesterday',
      time: '3:20 PM',
      icon: Icons.local_cafe,
      isIncome: false,
    ),
    TransactionData(
      title: 'Gas Station',
      subtitle: 'Transportation',
      amount: 45.20,
      date: '19/7/2025',
      time: '7:45 AM',
      icon: Icons.local_gas_station,
      isIncome: false,
    ),
    TransactionData(
      title: 'Freelance Project',
      subtitle: 'Additional Income',
      amount: 850.00,
      date: '18/7/2025',
      time: '4:00 PM',
      icon: Icons.work,
      isIncome: true,
    ),
    TransactionData(
      title: 'Netflix Subscription',
      subtitle: 'Entertainment',
      amount: 15.99,
      date: '17/7/2025',
      time: '12:00 PM',
      icon: Icons.play_circle_outline,
      isIncome: false,
    ),
  ];

  /// ============================= Lifecycle Methods =============================

  @override
  void initState() {
    super.initState();
    _transactionGroups = _groupTransactionsByDate(_recentTransactions);
  }

  /// ============================= Build Method =============================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Header with View All Button
        _buildSectionHeader(context),
        
        SizedBox(height: AppSpacing.xxs),
        
        /// Grouped Transaction List
        _buildGroupedTransactionList(),
      ],
    );
  }

  /// ============================= UI Building Methods =============================

  /// Builds the section header with title and View All button
  Widget _buildSectionHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recent Transactions',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.lightOnSurface,
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
                color: AppTheme.primarySeed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the grouped transaction list with date headers
  Widget _buildGroupedTransactionList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _transactionGroups.length,
      itemBuilder: (context, groupIndex) {
        return _buildTransactionGroup(_transactionGroups[groupIndex], groupIndex);
      },
    );
  }

  /// Builds a single transaction group with header and transactions
  Widget _buildTransactionGroup(TransactionGroup group, int groupIndex) {
    return Column(
      children: [
        /// Date Group Header
        DateGroupHeader(
          group: group,
        ),
        
        /// Transaction Items (if expanded)
        if (group.isExpanded) _buildTransactionItems(group),
        
        /// Spacing between groups
        if (groupIndex < _transactionGroups.length - 1)
          SizedBox(height: AppSpacing.md),
      ],
    );
  }

  /// Builds the list of transaction items for a group
  Widget _buildTransactionItems(TransactionGroup group) {
    return Column(
      children: group.transactions.asMap().entries.map((entry) {
        final index = entry.key;
        final transaction = entry.value;
        final isLast = index == group.transactions.length - 1;
        
        return TransactionItem(
          transaction: transaction,
          showDivider: !isLast,
          onTap: () => _handleTransactionTap(transaction),
        );
      }).toList(),
    );
  }

  /// ============================= Data Processing Methods =============================

  /// Groups transactions by date and calculates daily totals
  List<TransactionGroup> _groupTransactionsByDate(List<TransactionData> transactions) {
    final Map<String, List<TransactionData>> groupedData = {};
    final Map<String, DateTime> dateMap = {};
    
    // Group transactions by date
    for (final transaction in transactions) {
      final dateKey = transaction.date;
      groupedData[dateKey] ??= [];
      groupedData[dateKey]!.add(transaction);
      
      // Store actual date for sorting
      dateMap[dateKey] ??= _parseDate(dateKey);
    }
    
    // Convert to TransactionGroup objects
    final groups = groupedData.entries.map((entry) {
      final dateKey = entry.key;
      final transactions = entry.value;
      final actualDate = dateMap[dateKey]!;
      
      // Calculate daily total
      double total = 0;
      for (final transaction in transactions) {
        if (transaction.isIncome) {
          total += transaction.amount;
        } else {
          total -= transaction.amount;
        }
      }
      
      return TransactionGroup(
        date: actualDate,
        displayDate: dateKey,
        transactions: transactions,
        totalAmount: total,
        isExpanded: true, // Start with all groups expanded
      );
    }).toList();
    
    // Sort by date (newest first)
    groups.sort((a, b) => b.date.compareTo(a.date));
    
    return groups;
  }

  /// Parses date string to DateTime object
  DateTime _parseDate(String dateString) {
    final now = DateTime.now();
    
    switch (dateString.toLowerCase()) {
      case 'today':
        return now;
      case 'yesterday':
        return now.subtract(const Duration(days: 1));
      default:
        // Try to parse DD/MM/YYYY format
        try {
          final parts = dateString.split('/');
          if (parts.length == 3) {
            final day = int.parse(parts[0]);
            final month = int.parse(parts[1]);
            final year = int.parse(parts[2]);
            return DateTime(year, month, day);
          }
        } catch (e) {
          // Fallback to current date if parsing fails
        }
        return now.subtract(const Duration(days: 2)); // Default fallback
    }
  }

  /// ============================= Action Methods =============================
  /// Handles tap on individual transaction
  void _handleTransactionTap(TransactionData transaction) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Transaction details for ${transaction.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}