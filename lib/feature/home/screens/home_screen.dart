import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/home_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/home_quick_actions.dart';
import '../widgets/goals_progress_card.dart';
import '../widgets/transaction_history_item.dart';
import '../../../../core/helper/app_text_style.dart';
import '../../../../core/network/local_data.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../transactions/data/models/transaction_model.dart';
import '../data/repositories/home_repository.dart';
import '../presentation/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        repository: HomeRepository(),
      )..getDashboardData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              String? balance;
              String? activeGoal;
              List<TransactionModel> transactions = [];

              if (state is HomeSuccess) {
                balance = state.data.balance;
                activeGoal = state.data.activeGoal;
                transactions = state.data.recentTransactions;
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      HomeHeader(userName: LocalData.userName),
                      SizedBox(height: 24.h),
                      BalanceCard(balance: balance),
                      SizedBox(height: 24.h),
                      const HomeQuickActions(),
                      SizedBox(height: 32.h),

                      // Goals Section - Only show if activeGoal exists
                      if (activeGoal != null) ...[
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
                      ],

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
                            'Recent',
                            style: AppTextStyle.setPoppinsSecondaryText(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      if (state is HomeLoading)
                        const Center(
                            child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ))
                      else if (transactions.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(child: Text("No recent transactions")),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = transactions[index];
                            return _buildTransactionItem(transaction);
                          },
                        ),
                      SizedBox(height: 100.h), // Spacing for bottom nav
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(TransactionModel transaction) {
    bool? isIncoming;
    String title;

    // Determine Type
    if (transaction.type == 'DEPOSIT') {
      isIncoming = true;
      title = transaction.kiosk ?? 'Kiosk Deposit';
    } else {
      isIncoming = false;
      title = transaction.toSpace != null
          ? 'Proccess to ${transaction.toSpace}'
          : 'Transfer';
    }

    // Format Date
    String subtitle = transaction.createdAt;
    try {
      final dateTime = DateTime.parse(transaction.createdAt);
      subtitle = DateFormat('MMM d, h:mm a').format(dateTime);
    } catch (e) {}

    // We can use SVG assets if we map them, but for now using Icons to be safe or existing widget logic
    // The existing widget expects a Widget icon, so we can wrap generic Icons or use SvgPicture if we have specific assets

    Widget iconWidget;
    if (isIncoming == true) {
      iconWidget = SvgPicture.asset(
          'assets/onboarding/trans3.svg'); // Example asset for deposit
    } else {
      iconWidget = SvgPicture.asset(
          'assets/onboarding/trans2.svg'); // Example asset for transfer
    }

    return TransactionHistoryItem(
      title: title,
      subtitle: subtitle,
      points: 'Points ${transaction.amount}',
      icon: iconWidget,
      isIncoming: isIncoming,
    );
  }
}
