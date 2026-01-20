import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/app_text_style.dart';
import '../data/repository/space_repository.dart';
import '../manager/space_cubit.dart';
import '../manager/space_state.dart';
import '../widgets/space_grid_card.dart';
import '../widgets/bottom_sheets/goal_selection_bottom_sheet.dart';
import 'space_detail_screen.dart';

class SpacesScreen extends StatelessWidget {
  const SpacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpaceCubit(SpaceRepositoryImpl())..loadSpaces(),
      child: const _SpacesScreenContent(),
    );
  }
}

class _SpacesScreenContent extends StatelessWidget {
  const _SpacesScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Spaces',
          style: AppTextStyle.setPoppinsBlack(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<SpaceCubit, SpaceState>(
        listener: (context, state) {
          if (state is SpaceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is SpaceOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFF008751),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SpaceLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF008751),
              ),
            );
          }

          if (state is SpaceLoaded) {
            // Calculate total balance
            final totalBalance = state.spaces.fold<double>(
              0.0,
              (sum, space) => sum + space.currentAmount,
            );

            return CustomScrollView(
              slivers: [
                // Total Balance Section
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(16.w),
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total Balance',
                          style: AppTextStyle.setPoppinsSecondaryText(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Points ${totalBalance.toStringAsFixed(0)}',
                          style: AppTextStyle.setPoppinsBlack(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Grid of Spaces
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 1.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == state.spaces.length) {
                          // "New Space" card
                          return _NewSpaceCard(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (context) =>
                                    const GoalSelectionBottomSheet(),
                              );
                            },
                          );
                        }
                        // For existing spaces
                        final space = (state).spaces[index];
                        return SpaceGridCard(
                          space: space,
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        SpaceDetailScreen(spaceId: space.id),
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
                        );
                      },
                      childCount:
                          (state.spaces.length) + 1, // +1 for "New Space"
                    ),
                  ),
                ),

                // Bottom spacing
                SliverToBoxAdapter(
                  child: SizedBox(height: 16.h),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _NewSpaceCard extends StatelessWidget {
  final VoidCallback onTap;

  const _NewSpaceCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      const Color(0xFFC8E6C9), // Light teal/green from design
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: const Color(0xFF1B5E20), // Dark green
                    size: 32.r,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'New Space',
              style: AppTextStyle.setPoppinsTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF00695C), // Dark teal/green
              ),
            ),
          ],
        ),
      ),
    );
  }
}
