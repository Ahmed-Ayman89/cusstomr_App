import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/app_text_style.dart';
import '../data/models/space_model.dart';
import '../data/repository/space_repository.dart';
import '../manager/space_cubit.dart';
import '../manager/space_state.dart';
import 'space_settings_screen.dart';
import '../widgets/space_icon.dart';
import '../widgets/transfer/transfer_points_modal.dart';
import '../manager/transfer_cubit.dart';

class SpaceDetailScreen extends StatelessWidget {
  final String spaceId;

  const SpaceDetailScreen({super.key, required this.spaceId});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SpaceRepositoryImpl(),
      child: BlocProvider(
        create: (context) => SpaceCubit(context.read<SpaceRepositoryImpl>())
          ..loadSpaceDetail(spaceId),
        child: _SpaceDetailContent(spaceId: spaceId),
      ),
    );
  }
}

class _SpaceDetailContent extends StatelessWidget {
  final String spaceId;

  const _SpaceDetailContent({required this.spaceId});

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
        actions: [
          BlocBuilder<SpaceCubit, SpaceState>(
            builder: (context, state) {
              if (state is SpaceDetailLoaded) {
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: IconButton(
                    icon: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE0E0E0), // Light grey background
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.settings_outlined,
                          size: 20.r, color: Colors.grey.shade700),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SpaceSettingsScreen(space: state.space),
                        ),
                      ).then((_) {
                        // Reload space details when returning from settings
                        if (context.mounted) {
                          context.read<SpaceCubit>().loadSpaceDetail(spaceId);
                        }
                      });
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<SpaceCubit, SpaceState>(
        builder: (context, state) {
          if (state is SpaceLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF008751),
              ),
            );
          }

          if (state is SpaceDetailLoaded) {
            final space = state.space;
            // Use specific green color from design or fallback to space color
            // Design seems to use a consistent dark green for UI elements
            final themeColor = const Color(0xFF008751);

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Space Icon (Centered)
                    Center(
                      child: Container(
                        width: 140.w,
                        height: 100.h,
                        // The design shows a large illustration.
                        // Using the SVG asset directly without a container bg if possible, or keeping it clean.
                        child: SpaceIcon(
                          iconPath: space.iconAsset,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Balance Card
                    Container(
                      padding: EdgeInsets.all(20.r),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                'Points',
                                style: AppTextStyle.setPoppinsBlack(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${space.currentAmount.toInt()}',
                                style: AppTextStyle.setPoppinsBlack(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Total Balance',
                            style: AppTextStyle.setPoppinsSecondaryText(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            children: [
                              // Add Point Button
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showTransferModal(context,
                                        isDeposit: true, currentSpace: space);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: themeColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add,
                                          color: Colors.white, size: 18.r),
                                      SizedBox(width: 4.w),
                                      Text(
                                        'Add Point',
                                        style: AppTextStyle.setPoppinsTextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              // Move Point Button
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    _showTransferModal(context,
                                        isDeposit: false, currentSpace: space);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        BorderSide(color: Colors.grey.shade300),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_forward,
                                          color: Colors.grey.shade600,
                                          size: 18.r),
                                      SizedBox(width: 4.w),
                                      Text(
                                        'Move Point',
                                        style: AppTextStyle.setPoppinsTextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Your Progress
                    Text(
                      'Your Progress',
                      style: AppTextStyle.setPoppinsBlack(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (space.hasGoal && space.goalAmount != null) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Saved ${(space.progress * 100).toInt()}%',
                                  style: AppTextStyle.setPoppinsTextStyle(
                                    color: themeColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    text:
                                        'Points${space.currentAmount.toInt()}',
                                    style: AppTextStyle.setPoppinsBlack(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                    children: [
                                      TextSpan(
                                        text:
                                            '/Points${space.goalAmount!.toInt()}',
                                        style: AppTextStyle
                                            .setPoppinsSecondaryText(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4.r),
                              child: LinearProgressIndicator(
                                value: space.progress,
                                backgroundColor: Colors.grey.shade100,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(themeColor),
                                minHeight: 8.h,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            if (space.deadline != null)
                              Text(
                                'Deadline: ${_formatDate(space.deadline!)} . ${_calculateDaysLeft(space.deadline!)} days left',
                                style: AppTextStyle.setPoppinsSecondaryText(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            else
                              Text(
                                'No deadline set',
                                style: AppTextStyle.setPoppinsSecondaryText(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                          ] else ...[
                            Center(
                                child: Text("No Goal Set",
                                    style: AppTextStyle.setPoppinsSecondaryText(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))),
                          ]
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Transaction History Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transaction History',
                          style: AppTextStyle.setPoppinsBlack(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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

                    // Transaction Item (Mock)
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0F2F1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(Icons.credit_card,
                                color: themeColor, size: 24.r),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'To Main Account',
                                  style: AppTextStyle.setPoppinsBlack(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Yesterday, 11:30 PM',
                                  style: AppTextStyle.setPoppinsSecondaryText(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Points 500',
                            style: AppTextStyle.setPoppinsBlack(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ,${date.day} ${date.year}';
  }

  int _calculateDaysLeft(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);
    return difference.inDays > 0 ? difference.inDays : 0;
  }

  void _showTransferModal(BuildContext context,
      {required bool isDeposit, required SpaceModel currentSpace}) {
    final repo = context.read<SpaceRepositoryImpl>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => BlocProvider(
        create: (context) => TransferCubit(repo),
        child: FutureBuilder(
          future: repo.getSpaces(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final spaces = snapshot.data ?? [];
            // Remove current space from available options if moving FROM it (actually logic handled in cubit, but good to filter)
            // But for now pass all

            return TransferPointsModal(
              availableSpaces: spaces,
              initialSource:
                  isDeposit ? null : currentSpace, // null = Main Account
              initialDestination:
                  isDeposit ? currentSpace : null, // null = User Chooses
            );
          },
        ),
      ),
    ).then((_) {
      // Refresh
      if (context.mounted) {
        context.read<SpaceCubit>().loadSpaceDetail(spaceId);
      }
    });
  }
}
