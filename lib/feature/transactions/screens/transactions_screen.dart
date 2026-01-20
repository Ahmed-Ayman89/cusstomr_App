import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/helper/app_text_style.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Transaction',
          style: AppTextStyle.setPoppinsBlack(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          children: [
            // Green Summary Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF00A67E), Color(0xFF00695C)]),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/transcation.svg',
                      height: 35.h,
                      width: 35.w,
                      fit: BoxFit.scaleDown,
                      color: AppColors.brandPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Transaction this month',
                    style: AppTextStyle.setPoppinsWhite(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '+300',
                    style: AppTextStyle.setPoppinsWhite(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Points Added',
                    style: AppTextStyle.setPoppinsWhite(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Transactions List
            _buildTransactionItem(
              icon: Icons.credit_card,
              iconColor: const Color(0xFF00695C),
              badgeIcon: Icons.arrow_forward,
              title: 'To Main Account',
              date: 'Today , 12:30 PM',
              amount: '300',
              bgIconColor: const Color(0xFFE0F2F1),
            ),
            SizedBox(height: 12.h),
            _buildTransactionItem(
              icon: Icons.storefront,
              iconColor: const Color(0xFF00695C),
              title: 'Kiosk EL-Nasr',
              date: 'Yesterday , 11:30 PM',
              amount: '500',
              bgIconColor: const Color(0xFFE8F5E9),
            ),
            SizedBox(height: 12.h),
            _buildTransactionItem(
              icon: Icons.menu_book, // Education icon placeholder
              iconColor: const Color(0xFF00695C),
              badgeIcon: Icons.arrow_back,
              title: 'To Education',
              date: 'Yesterday , 11:30 PM',
              amount: '500',
              bgIconColor: const Color(0xFFE0F2F1),
            ),
            SizedBox(height: 12.h),
            _buildTransactionItem(
              icon: Icons.credit_card,
              iconColor: const Color(0xFF00695C),
              badgeIcon: Icons.arrow_forward,
              title: 'To Main Account',
              date: 'Yesterday , 12:00 PM',
              amount: '500',
              bgIconColor: const Color(0xFFE0F2F1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required Color iconColor,
    IconData? badgeIcon,
    required String title,
    required String date,
    required String amount,
    required Color bgIconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          // Icon with Badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: bgIconColor,
                  borderRadius: BorderRadius.circular(24.r), // Circle
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24.r,
                ),
              ),
              if (badgeIcon != null)
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: const BoxDecoration(
                      color: Color(0xFF4DB6AC), // Teal/Green badge
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      badgeIcon,
                      size: 10.r,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.setPoppinsBlack(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  date,
                  style: AppTextStyle.setPoppinsSecondaryText(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            'Points $amount',
            style: AppTextStyle.setPoppinsBlack(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
