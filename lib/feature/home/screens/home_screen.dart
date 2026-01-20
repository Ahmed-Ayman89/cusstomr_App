import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/home_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/home_quick_actions.dart';
import '../widgets/goals_progress_card.dart';
import '../widgets/transaction_history_item.dart';
import '../../../../core/helper/app_text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                const HomeHeader(),
                SizedBox(height: 24.h),
                const BalanceCard(),
                SizedBox(height: 24.h),
                const HomeQuickActions(),
                SizedBox(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Goals',
                      style: AppTextStyle.setPoppinsBlack(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                const GoalsProgressCard(),
                SizedBox(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transaction History',
                      style: AppTextStyle.setPoppinsBlack(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Today',
                      style: AppTextStyle.setPoppinsSecondaryText(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                TransactionHistoryItem(
                  title: 'From Home Space',
                  subtitle: 'Yesterday , 11:30 PM',
                  points: '+Points 500',
                  icon: SvgPicture.asset(
                      'assets/onboarding/Group 1171274949.svg'),
                  isIncoming: true,
                ),
                TransactionHistoryItem(
                  title: 'To Education',
                  subtitle: 'Yesterday , 11:30 PM',
                  points: 'Points 500',
                  icon: SvgPicture.asset('assets/onboarding/trans2.svg'),
                  isIncoming: false,
                ),
                TransactionHistoryItem(
                  title: 'Kiosk EL-Nasr',
                  subtitle: 'Yesterday , 11:30 PM',
                  points: 'Points 500',
                  icon: SvgPicture.asset('assets/onboarding/trans3.svg'),
                  isIncoming: null,
                ),
                SizedBox(height: 100.h), // Spacing for bottom nav
              ],
            ),
          ),
        ),
      ),
    );
  }
}
