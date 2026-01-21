import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/helper/app_text_style.dart';
import '../../auth/widgets/Cusstom_btn.dart';
import 'create_space_screen.dart';

class GoalIntroScreen extends StatelessWidget {
  const GoalIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.r, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              SvgPicture.asset(
                'assets/onboarding/Coins.svg', // Default or specific image for intro
                height: 120.h,
                // width: 120.w,
              ),
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Plan and Save up Your Points',
                  style: AppTextStyle.setPoppinsBlack(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Put points aside & save up for purchases,\ntrips or big moments',
                  style: AppTextStyle.setPoppinsSecondaryText(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              _buildFeatureItem(
                icon: Icons.add_circle,
                text: 'Add your points in your space to\nsave up easily',
              ),
              SizedBox(height: 24.h),
              _buildFeatureItem(
                icon: Icons.shield_outlined,
                text: 'No Fees applied',
              ),
              SizedBox(height: 24.h),
              _buildFeatureItem(
                icon: Icons.lock_outline,
                text: 'No Minimum Deposit',
              ),
              SizedBox(height: 24.h),
              _buildFeatureItem(
                icon: Icons.swap_horiz,
                text:
                    'Withdraw and move point to & from\nyour space at any time',
              ),
              const Spacer(),
              CustomButton(
                title: 'Create Space',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateSpaceScreen(),
                    ),
                  );
                },
                color: const Color(0xFF008751),
                textColor: Colors.white,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9), // Light green bg
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xFF5D6B65), // Icon color
            size: 20.r,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.setPoppinsBlack(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
