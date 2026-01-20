import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/helper/app_text_style.dart';
import '../../auth/widgets/Cusstom_btn.dart';

class AddPointInfoScreen extends StatelessWidget {
  const AddPointInfoScreen({super.key});

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
        title: Text(
          'Add Point',
          style: AppTextStyle.setPoppinsBlack(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              // Illustration
              Image.asset(
                'assets/onboarding/trans3.svg',
                height: 120.h,
                width: 120.w,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return SvgPicture.asset('assets/onboarding/rafiki.svg');
                },
              ),
              SizedBox(height: 32.h),

              // Subtitle
              Text(
                'Add points from the nearest\nverified kiosk',
                textAlign: TextAlign.center,
                style: AppTextStyle.setPoppinsSecondaryText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 40.h),

              // Steps
              _buildStep(
                number: '1',
                text:
                    'Open the map and choose the closest kiosk that supports adding points',
              ),
              SizedBox(height: 20.h),
              _buildStep(
                number: '2',
                text: 'Share your phone number with the kiosk employee.',
              ),
              SizedBox(height: 20.h),
              _buildStep(
                number: '3',
                text:
                    'Your points will be added based on the transaction value',
              ),

              Spacer(),

              // Dismiss Button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  title: 'Dismiss',
                  onPressed: () => Navigator.pop(context),
                  color: const Color(0xFF008751),
                  textColor: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep({required String number, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: AppTextStyle.setPoppinsTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF008751),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.setPoppinsBlack(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
