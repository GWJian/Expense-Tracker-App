import 'package:flutter/material.dart';

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
    this.time,
  });

  final String title;
  final String subtitle;
  final double amount;
  final String date;
  final IconData icon;
  final bool isIncome;
  final String? time; // Optional time for display (e.g., "10:30 AM")
}

/// ============================= Grouped Transaction Model =============================
///
/// Data model for transactions grouped by date
/// Contains date information, transactions list, and calculated totals
class TransactionGroup {
  const TransactionGroup({
    required this.date,
    required this.displayDate,
    required this.transactions,
    required this.totalAmount,
    required this.isExpanded,
  });

  final DateTime date; // Actual date for sorting
  final String displayDate; // Display format (Today, Yesterday, 19/7/2025)
  final List<TransactionData> transactions; // Transactions for this date
  final double totalAmount; // Net total for the day (income - expenses)
  final bool isExpanded; // Whether the group is expanded

  /// Returns the count of transactions in this group
  int get transactionCount => transactions.length;

  /// Returns whether this is a net positive day
  bool get isPositiveDay => totalAmount >= 0;

  /// Returns formatted total amount with RM currency
  String get formattedTotal {
    final prefix = totalAmount >= 0 ? '+' : '';
    return '${prefix}RM${totalAmount.abs().toStringAsFixed(2)}';
  }

  /// Creates a copy of this group with updated expansion state
  TransactionGroup copyWith({
    DateTime? date,
    String? displayDate,
    List<TransactionData>? transactions,
    double? totalAmount,
    bool? isExpanded,
  }) {
    return TransactionGroup(
      date: date ?? this.date,
      displayDate: displayDate ?? this.displayDate,
      transactions: transactions ?? this.transactions,
      totalAmount: totalAmount ?? this.totalAmount,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}