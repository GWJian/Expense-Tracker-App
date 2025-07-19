import 'package:flutter/material.dart';
import '../../../components/navigation/custom_app_bar.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_actions.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';

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
              
              /// Recent Transactions Section (placeholder for Step 4.2)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.lightSurfaceVariant.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Transactions',
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Text(
                      'Coming soon in Step 4.2',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.lightOnSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}