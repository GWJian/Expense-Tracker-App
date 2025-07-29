import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.responsivePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// ============================= Logo Section =============================
              SizedBox(
                width: 96.0,
                height: 96.0,
                child: Image.asset(
                  'assets/images/wallet_icon.png',
                  width: 48.0,
                  height: 48.0,
                ),
              ),
              
              const SizedBox(height: AppSpacing.huge),
              
              /// ============================= Welcome Text =============================
              Text(
                'Welcome to',
                style: AppTextStyles.headlineMedium,
              ),
              
              const SizedBox(height: AppSpacing.sm),
              
              Text(
                'Expense Tracker',
                style: AppTextStyles.displayMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primarySeed,
                ),
              ),
              
              const SizedBox(height: AppSpacing.lg),
              
              Text(
                'A place where you can track all your\nexpenses and incomes...',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppTheme.lightOnSurfaceVariant,
                ),
              ),

              const SizedBox(height: AppSpacing.huge),
              
              /// ============================= Auth Buttons =============================
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Navigate to main screen (temporary for UI development)
                    context.go('/main');
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppTheme.lightOutline,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  ),
                  icon: Text(
                    'G',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppTheme.lightOnSurface,
                    ),
                  ),
                  label: Text(
                    'Continue with Google',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppTheme.lightOnSurface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}