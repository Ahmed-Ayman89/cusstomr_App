import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/helper/app_text_style.dart';
import '../data/models/transaction_model.dart';
import '../data/repositories/transactions_repository.dart';
import '../presentation/cubit/transactions_cubit.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionsCubit(
        repository: TransactionsRepository(),
      )..getTransactions(),
      child: Scaffold(
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
        body: BlocBuilder<TransactionsCubit, TransactionsState>(
          builder: (context, state) {
            if (state is TransactionsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionsFailure) {
              return Center(child: Text(state.message));
            } else if (state is TransactionsSuccess) {
              final data = state.data;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  children: [
                    // Green Summary Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
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
                            data.total, // Display real total
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
                    if (data.transactions.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Text("No transactions found"),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.transactions.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final transaction = data.transactions[index];
                          return _buildTransactionItemFromModel(transaction);
                        },
                      ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildTransactionItemFromModel(TransactionModel transaction) {
    IconData icon;
    IconData? badgeIcon;
    Color bgIconColor;
    String title;

    bool isDeposit = transaction.type == 'DEPOSIT';
    if (isDeposit) {
      icon = Icons.storefront;
      bgIconColor = const Color(0xFFE8F5E9);
      title = transaction.kiosk ?? 'Kiosk Deposit';
    } else {
      // Transfer
      icon = Icons.credit_card;
      bgIconColor = const Color(0xFFE0F2F1);
      title = transaction.toSpace != null
          ? 'To ${transaction.toSpace}'
          : 'Transfer';
      // Adjust badge direction if needed, but simple logic for now:
      badgeIcon = Icons.arrow_forward;
    }

    String formattedDate = transaction.createdAt;
    try {
      final dateTime = DateTime.parse(transaction.createdAt);
      formattedDate =
          DateFormat('MMM d, h:mm a').format(dateTime); // e.g. Jan 25, 10:09 AM
    } catch (e) {
      // Keep original string if parse fails
    }

    return _buildTransactionItem(
      icon: icon,
      iconColor: const Color(0xFF00695C),
      badgeIcon: badgeIcon,
      title: title,
      date: formattedDate,
      amount: transaction.amount,
      bgIconColor: bgIconColor,
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
