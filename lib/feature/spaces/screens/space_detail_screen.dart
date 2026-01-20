import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../auth/widgets/Cusstom_btn.dart';
import '../../../core/helper/app_text_style.dart';
import '../data/repository/space_repository.dart';
import '../manager/space_cubit.dart';
import '../manager/space_state.dart';
import 'set_goal_screen.dart';

class SpaceDetailScreen extends StatelessWidget {
  final String spaceId;

  const SpaceDetailScreen({super.key, required this.spaceId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SpaceCubit(SpaceRepositoryImpl())..loadSpaceDetail(spaceId),
      child: _SpaceDetailContent(spaceId: spaceId),
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
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, size: 24.r, color: Colors.black),
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteDialog(context);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 20.r, color: Colors.red),
                    SizedBox(width: 8.w),
                    Text(
                      'Delete Space',
                      style: AppTextStyle.setPoppinsTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
            final color = Color(int.parse(space.color.replaceAll('#', '0xFF')));

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.h),
                    // Icon
                    Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Center(
                        child: space.iconAsset.endsWith('.svg')
                            ? SvgPicture.asset(
                                space.iconAsset,
                                width: 60.w,
                                height: 60.h,
                                colorFilter: ColorFilter.mode(
                                  color,
                                  BlendMode.srcIn,
                                ),
                              )
                            : Icon(Icons.savings_outlined,
                                size: 60.r, color: color),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Space Name
                    Text(
                      space.name,
                      style: AppTextStyle.setPoppinsBlack(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Current Amount
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: color.withOpacity(0.2)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Current Balance',
                            style: AppTextStyle.setPoppinsSecondaryText(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'EGP ${space.currentAmount.toStringAsFixed(2)}',
                            style: AppTextStyle.setPoppinsBlack(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Goal Section
                    if (space.hasGoal && space.goalAmount != null) ...[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Goal',
                                  style: AppTextStyle.setPoppinsSecondaryText(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'EGP ${space.goalAmount!.toStringAsFixed(2)}',
                                  style: AppTextStyle.setPoppinsBlack(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            LinearProgressIndicator(
                              value: space.progress,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(color),
                              borderRadius: BorderRadius.circular(4.r),
                              minHeight: 8.h,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              '${(space.progress * 100).toStringAsFixed(1)}% Complete',
                              style: AppTextStyle.setPoppinsSecondaryText(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.track_changes,
                              size: 32.r,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'No goal set yet',
                              style: AppTextStyle.setPoppinsSecondaryText(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Set a savings goal to track your progress',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.setPoppinsSecondaryText(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const Spacer(),

                    // Actions
                    if (!space.hasGoal || space.goalAmount == null)
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          title: 'Set Goal',
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        SetGoalScreen(space: space),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            ).then((_) {
                              context
                                  .read<SpaceCubit>()
                                  .loadSpaceDetail(spaceId);
                            });
                          },
                          color: color,
                          textColor: Colors.white,
                        ),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          title: space.isGoalCompleted
                              ? 'Goal Completed!'
                              : 'Manage Space',
                          onPressed: () {
                            // Navigate to manage space
                          },
                          color: space.isGoalCompleted
                              ? const Color(0xFF4CAF50)
                              : color,
                          textColor: Colors.white,
                        ),
                      ),
                    SizedBox(height: 16.h),
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

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Delete Space',
          style: AppTextStyle.setPoppinsBlack(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this space? This action cannot be undone.',
          style: AppTextStyle.setPoppinsSecondaryText(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: AppTextStyle.setPoppinsSecondaryText(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<SpaceCubit>().deleteSpace(spaceId);
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: AppTextStyle.setPoppinsTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
