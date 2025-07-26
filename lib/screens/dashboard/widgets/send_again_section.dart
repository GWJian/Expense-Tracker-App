import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';

/// ============================= Send Again Section =============================
/// Horizontal scrollable list of hardcoded contacts/merchants for quick repeat transactions
/// Displays merchant icons, names, and quick action buttons (UI only)

class SendAgainSection extends StatelessWidget {
  const SendAgainSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(),
        SizedBox(height: AppSpacing.lg),
        _buildMerchantsList(),
      ],
    );
  }

  /// ============================= Section Header =============================
  Widget _buildSectionHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Send Again',
            style: AppTextStyles.titleLargeBold.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
          GestureDetector(
            onTap: () {
              // TODO: Navigate to full send again list
            },
            child: Text(
              'See All',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ============================= Merchants List =============================
  Widget _buildMerchantsList() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
        itemCount: _merchantsData.length,
        itemBuilder: (context, index) {
          final merchant = _merchantsData[index];
          return _buildMerchantCard(merchant);
        },
      ),
    );
  }

  /// ============================= Merchant Card =============================
  Widget _buildMerchantCard(MerchantData merchant) {
    return Container(
      width: 90,
      margin: EdgeInsets.only(right: AppSpacing.lg),
      child: Column(
        children: [
          _buildMerchantIcon(merchant),
          SizedBox(height: AppSpacing.sm),
          _buildMerchantName(merchant.name),
          SizedBox(height: AppSpacing.xs),
          _buildLastAmount(merchant.lastAmount),
        ],
      ),
    );
  }

  /// ============================= Merchant Icon =============================
  Widget _buildMerchantIcon(MerchantData merchant) {
    return GestureDetector(
      onTap: () {
        // TODO: Handle repeat transaction tap
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: merchant.backgroundColor,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey300,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          merchant.icon,
          size: AppSpacing.iconLarge,
          color: merchant.iconColor,
        ),
      ),
    );
  }

  /// ============================= Merchant Name =============================
  Widget _buildMerchantName(String name) {
    return Text(
      name,
      style: AppTextStyles.labelMedium.copyWith(
        color: AppColors.primaryDark,
      ),
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// ============================= Last Amount =============================
  Widget _buildLastAmount(String amount) {
    return Text(
      amount,
      style: AppTextStyles.caption.copyWith(
        color: AppColors.grey600,
      ),
      textAlign: TextAlign.center,
    );
  }
}

/// ============================= Merchant Data Model =============================
class MerchantData {
  final String name;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String lastAmount;

  const MerchantData({
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.lastAmount,
  });
}

/// ============================= Hardcoded Merchants Data =============================
final List<MerchantData> _merchantsData = [
  MerchantData(
    name: 'Starbucks',
    icon: Icons.local_cafe,
    iconColor: AppColors.white,
    backgroundColor: Color(0xFF00704A),
    lastAmount: '\$4.95',
  ),
  MerchantData(
    name: 'Uber',
    icon: Icons.local_taxi,
    iconColor: AppColors.white,
    backgroundColor: AppColors.primaryDark,
    lastAmount: '\$12.30',
  ),
  MerchantData(
    name: 'Netflix',
    icon: Icons.play_circle_filled,
    iconColor: AppColors.white,
    backgroundColor: Color(0xFFE50914),
    lastAmount: '\$15.99',
  ),
  MerchantData(
    name: 'McDonald\'s',
    icon: Icons.fastfood,
    iconColor: Color(0xFFFFC72C),
    backgroundColor: Color(0xFFDA020E),
    lastAmount: '\$8.75',
  ),
  MerchantData(
    name: 'Amazon',
    icon: Icons.shopping_bag,
    iconColor: AppColors.white,
    backgroundColor: Color(0xFF232F3E),
    lastAmount: '\$29.99',
  ),
  MerchantData(
    name: 'Spotify',
    icon: Icons.music_note,
    iconColor: AppColors.white,
    backgroundColor: Color(0xFF1DB954),
    lastAmount: '\$9.99',
  ),
  MerchantData(
    name: 'Shell',
    icon: Icons.local_gas_station,
    iconColor: AppColors.white,
    backgroundColor: Color(0xFFFFD100),
    lastAmount: '\$45.20',
  ),
  MerchantData(
    name: 'Target',
    icon: Icons.store,
    iconColor: AppColors.white,
    backgroundColor: Color(0xFFCC0000),
    lastAmount: '\$22.50',
  ),
];