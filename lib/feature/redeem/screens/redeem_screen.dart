import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helper/app_text_style.dart';
import '../../auth/widgets/Cusstom_btn.dart';
import '../../auth/widgets/custom_text_field.dart';

class RedeemScreen extends StatelessWidget {
  final String title;
  final String iconAsset;
  final String inputLabel;
  final String inputHint;

  const RedeemScreen({
    super.key,
    required this.title,
    required this.iconAsset,
    required this.inputLabel,
    required this.inputHint,
  });

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
          title,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo Area
              Center(
                child: Image.asset(
                  iconAsset,
                  height: 100.h,
                  width: 100.w, // Approximate width constraint
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback for SVGs if passed by mistake or broken image
                    if (iconAsset.endsWith('.svg')) {
                      return SvgPicture.asset(iconAsset, height: 60.h);
                    }
                    return Icon(Icons.broken_image,
                        size: 60.h, color: Colors.grey);
                  },
                ),
              ),
              SizedBox(height: 48.h),

              // Account/Wallet Input
              Text(
                inputLabel,
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                hintText: inputHint,
              ),
              SizedBox(height: 24.h),

              // Points Input
              Text(
                'Points to Redeem',
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                hintText: 'Enter points amount',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8.h),
              Text('Minimum redeem is 10 Points',
                  style: AppTextStyle.setPoppinsBlack(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )),

              Spacer(),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  title: 'Confirm Redeem',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(24.r),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified_outlined,
                                size: 60.r,
                                color: const Color(0xFF008751),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'Confirm',
                                style: AppTextStyle.setPoppinsBlack(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Your points have been successfully redeemed.',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.setPoppinsSecondaryText(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 24.h),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close dialog
                                  Navigator.pop(context); // Back to home
                                },
                                child: Text(
                                  'OK',
                                  style: AppTextStyle.setPoppinsBrandPrimary(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ).copyWith(color: const Color(0xFF008751)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
}
