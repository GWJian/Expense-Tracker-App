import 'package:expense_tracker_app/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
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
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              
              const SizedBox(height: AppSpacing.sm),
              
              Text(
                'Expense Tracker',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              
              const SizedBox(height: AppSpacing.lg),
              
              Text(
                'A place where you can track all your\nexpenses and incomes...',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: AppSpacing.huge),
              
              /// ============================= Auth Buttons =============================
              SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeight,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement Google sign-in
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                    ),
                    padding: context.responsiveButtonEdgeInsets,
                  ),
                  icon: Text(
                    'G',
                    style: AppTextStyles.titleLargeBold.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  label: Text(
                    'Continue with Google',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
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