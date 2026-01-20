import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/feature/auth/screens/passcode_screen.dart';
import 'package:flutter_application_1/feature/auth/widgets/Cusstom_btn.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_application_1/core/helper/app_text_style.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';

enum VerificationNextStep { createPasscode, login, resetPasscode }

class VerificationCodeScreen extends StatelessWidget {
  final VerificationNextStep nextStep;

  const VerificationCodeScreen({
    super.key,
    this.nextStep = VerificationNextStep.createPasscode,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 72.w,
      height: 72.w,
      textStyle: AppTextStyle.setPoppinsBlack(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.brandPrimary),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.white,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Verification Code',
          style: AppTextStyle.setPoppinsBlack(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),
                Center(
                  child: SvgPicture.asset(
                    'assets/cuate.svg',
                    height: 174.h,
                    width: 174.w,
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.w),
                  child: Text(
                    "A verification code has been sent to your phone via SMS. Enter the code to proceed",
                    style: AppTextStyle.setPoppinsSecondaryText(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ).copyWith(height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 32.h),

                // Pinput Widget
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 4,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    showCursor: true,
                    onCompleted: (pin) => _handleVerify(context),
                  ),
                ),

                SizedBox(height: 32.h),
                // Resend Code Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive code?",
                      style: AppTextStyle.setPoppinsSecondaryText(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () {
                        // Resend logic placeholder
                      },
                      child: Text(
                        "Resend Code",
                        style: AppTextStyle.setPoppinsBrandPrimary(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ).copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 48.h),
                CustomButton(
                  title: 'Verify',
                  onPressed: () {
                    _handleVerify(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleVerify(BuildContext context) {
    if (nextStep == VerificationNextStep.login) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PasscodeScreen(mode: PasscodeMode.login),
        ),
      );
    } else {
      // Both Create and Reset flows lead to Creating a NEW passcode
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PasscodeScreen(mode: PasscodeMode.create),
        ),
      );
    }
  }
}
