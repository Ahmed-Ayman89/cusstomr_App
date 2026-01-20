import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/router/routes.dart';
import '../../../core/helper/app_text_style.dart';
import '../widgets/contact_us_dialog.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'More',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1
            Text(
              'Your Guide to Saving with Grow',
              style: AppTextStyle.setPoppinsSecondaryText(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _buildOptionCard(
                    context,
                    title: 'FAQS',
                    iconPath: 'assets/onboarding/FAQS.svg',
                    onTap: () {
                      Navigator.pushNamed(context, Routes.faqsScreen);
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildOptionCard(
                    context,
                    title: 'About Grow',
                    iconPath: 'assets/onboarding/grow.svg',
                    onTap: () {
                      Navigator.pushNamed(context, Routes.aboutGrowScreen);
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 32.h),

            // Section 2
            Text(
              'Getting to Know Us',
              style: AppTextStyle.setPoppinsSecondaryText(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _buildOptionCard(
                    context,
                    title: 'Contact us',
                    iconPath: 'assets/icons/profile-circle.svg',
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => const ContactUsDialog(),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildOptionCard(
                    context,
                    title: 'Know your rights',
                    iconPath: 'assets/icons/noto_bank.svg',
                    onTap: () {
                      Navigator.pushNamed(context, Routes.knowYourRightsScreen);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 100.w,
        height: 79.h,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 32.h,
              width: 32.w,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: AppTextStyle.setPoppinsBlack(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
