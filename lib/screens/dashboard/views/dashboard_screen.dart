import 'package:flutter/material.dart';
import '../../../components/navigation/custom_app_bar.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_transactions.dart';
import '../../../theme/app_spacing.dart';

/// ============================= Dashboard Screen =============================
/// 
/// Main dashboard screen showing balance overview and quick actions
/// Implements Step 4.1: Balance Overview from UI development guide
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  /// ============================= Build Method =============================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        greeting: 'John Doe', // Hardcoded user name as per requirements
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Balance Card - Prominent display of total balance
              const BalanceCard(),
              
              SizedBox(height: AppSpacing.lg),
              
              /// Quick Actions - Add Transaction and Pay Bill buttons
              const QuickActions(),
              
              SizedBox(height: AppSpacing.lg),
              
              /// Recent Transactions Section (Step 4.2)
              const RecentTransactions(),
            ],
          ),
        ),
      ),
    );
  }
}