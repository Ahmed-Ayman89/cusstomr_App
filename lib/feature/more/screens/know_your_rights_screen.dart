import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/app_text_style.dart';

class KnowYourRightsScreen extends StatelessWidget {
  const KnowYourRightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.r),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Know your Rights',
          style: AppTextStyle.setPoppinsBlack(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            _buildRightItem(
              title: 'Terms and Conditions',
              description:
                  'Learn about the rules and policies that govern your use of the Grow app, to ensure a safe and transparent experience',
              onTap: () {
                // Navigate to Terms
              },
            ),
            SizedBox(height: 16.h),
            _buildRightItem(
              title: 'Privacy Policy',
              description:
                  'We respect your privacy and are committed to protecting your data. Learn how your information is collected , used , and safeguarded',
              onTap: () {
                // Navigate to Privacy Policy
              },
            ),
            SizedBox(height: 16.h),
            _buildRightItem(
              title: 'Pricing and Fees',
              description:
                  'Everything you need to know about Grow`s services fees-from transfers and withdrawals to goal management.',
              onTap: () {
                // Navigate to Pricing
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightItem({
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyle.setPoppinsBlack(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 14.r, color: Colors.grey),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              description,
              style: AppTextStyle.setPoppinsSecondaryText(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ).copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
