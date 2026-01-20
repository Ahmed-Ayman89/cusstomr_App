import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/app_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'bottom_sheets/action_bottom_sheet.dart';
import '../../redeem/screens/redeem_screen.dart';
import '../../add_point/screens/add_point_info_screen.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionButton(
            title: 'Add Point',
            icon: Icons.north_east,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => ActionBottomSheet(
                  title: 'Select how to add point to your\nGrow account',
                  children: [
                    ActionItemWidget(
                      icon: SvgPicture.asset(
                        'assets/onboarding/trans3.svg',
                        height: 45.h,
                        width: 45.w,
                      ),
                      title: 'Grow Merchant',
                      statusText: 'Available',
                      statusColor: const Color(0xFF008751),
                      iconBackgroundColor:
                          const Color(0xFFE8F5E9), // Light Green
                      onTap: () {
                        Navigator.pop(context); // Close bottom sheet
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const AddPointInfoScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ActionItemWidget(
                      icon: Icon(Icons.credit_card, size: 24.r),
                      title: 'Use a Debit/Credit card',
                      isSoon: true,
                      onTap: () {},
                    ),
                    ActionItemWidget(
                      icon: Icon(Icons.account_balance, size: 24.r),
                      title: 'Add through bank accounts',
                      isSoon: true,
                      onTap: () {},
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _QuickActionButton(
            title: 'Redeem Point',
            icon: Icons.south_west,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => ActionBottomSheet(
                  title: 'Choose Space',
                  children: [
                    ActionItemWidget(
                      icon: Image.asset(
                        'assets/onboarding/insta.png',
                        width: 24.w,
                        fit: BoxFit.contain,
                      ),
                      title: 'InstaPay - Bank',
                      subtitle: 'Instant transfer to your bank account',
                      onTap: () {
                        Navigator.pop(context); // Close bottom sheet
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const RedeemScreen(
                              title: 'Redeem Instapay',
                              iconAsset: 'assets/onboarding/insta.png',
                              inputLabel: 'Bank Account Number',
                              inputHint: 'Enter Bank Account Number',
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ActionItemWidget(
                      icon: Image.asset(
                        'assets/onboarding/insta.png',
                        width: 24.w,
                        fit: BoxFit.contain,
                      ),
                      title: 'InstaPay - Wallet',
                      subtitle: 'Instant transfer to your mobile wallet',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const RedeemScreen(
                              title: 'Redeem Instapay',
                              iconAsset: 'assets/onboarding/insta.png',
                              inputLabel: 'Wallet Number',
                              inputHint: 'Enter Wallet Number',
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ActionItemWidget(
                      icon: Image.asset(
                        'assets/voda.png',
                        width: 24.w,
                        fit: BoxFit.contain,
                      ),
                      title: 'Use a Vodafone Cash',
                      subtitle: 'Instant wallet transfer',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const RedeemScreen(
                              title: 'Redeem Vodafone',
                              iconAsset: 'assets/voda.png',
                              inputLabel: 'Wallet Number',
                              inputHint: 'Enter Wallet Number',
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ActionItemWidget(
                      icon: Image.asset(
                        'assets/Orange.png',
                        width: 24.w,
                        fit: BoxFit.contain,
                      ),
                      title: 'Use a Orange Cash',
                      subtitle: 'Instant wallet transfer',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const RedeemScreen(
                              title: 'Redeem Orange',
                              iconAsset: 'assets/Orange.png',
                              inputLabel: 'Wallet Number',
                              inputHint: 'Enter Wallet Number',
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ActionItemWidget(
                      icon: Image.asset(
                        'assets/etisalat.png',
                        width: 24.w,
                        fit: BoxFit.contain,
                      ),
                      title: 'Use a Etisalat Cash',
                      subtitle: 'Instant wallet transfer',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const RedeemScreen(
                              title: 'Redeem Etisalat',
                              iconAsset: 'assets/etisalat.png',
                              inputLabel: 'Wallet Number',
                              inputHint: 'Enter Wallet Number',
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const _QuickActionButton({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20.r, color: Colors.black),
          SizedBox(width: 8.w),
          Text(
            title,
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
