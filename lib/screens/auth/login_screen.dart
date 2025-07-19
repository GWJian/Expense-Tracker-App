import 'package:expense_tracker_app/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.responsiveScreenEdgeInsets,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// ============================= Logo Section =============================
              SizedBox(
                width: context.responsiveIconSize(baseSize: AppSpacing.iconExtraLarge) * 2,
                height: context.responsiveIconSize(baseSize: AppSpacing.iconExtraLarge) * 2,
                child: Image.asset(
                  'assets/images/wallet_icon.png',
                  width: context.responsiveIconSize(baseSize: AppSpacing.iconExtraLarge),
                  height: context.responsiveIconSize(baseSize: AppSpacing.iconExtraLarge),
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
                  color: AppColors.primary,
                ),
              ),
              
              const SizedBox(height: AppSpacing.lg),
              
              Text(
                'A place where you can track all your\nexpenses and incomes...',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.lightOnSurfaceVariant,
                ),
              ),

              const SizedBox(height: AppSpacing.huge),
              
              /// ============================= Auth Buttons =============================
              SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeight,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Navigate to main screen (temporary for UI development)
                    Navigator.pushReplacementNamed(context, '/main');
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppColors.lightOutline,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                    ),
                    padding: context.responsiveButtonEdgeInsets,
                  ),
                  icon: Text(
                    'G',
                    style: AppTextStyles.titleLargeBold.copyWith(
                      color: AppColors.lightOnSurface,
                    ),
                  ),
                  label: Text(
                    'Continue with Google',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.lightOnSurface,
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