import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/app_text_style.dart';
import '../data/repository/faq_repository.dart';
import '../manager/faq_cubit.dart';
import '../manager/faq_state.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FaqCubit(FaqRepository())..loadFaqs(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.r),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'FAQS',
            style: AppTextStyle.setPoppinsBlack(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<FaqCubit, FaqState>(
          builder: (context, state) {
            if (state is! FaqLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            final categories = ['About Grow', 'Saving', 'Redeem', 'Register'];

            return Column(
              children: [
                SizedBox(height: 16.h),
                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: categories.map((category) {
                      final isSelected = state.selectedCategory == category;
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: ChoiceChip(
                          label: Text(
                            category,
                            style: AppTextStyle.setPoppinsTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              context.read<FaqCubit>().selectCategory(category);
                            }
                          },
                          backgroundColor: Colors.white,
                          selectedColor: const Color(0xFF1B5E20), // Dark green
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            side: BorderSide(
                              color: isSelected
                                  ? const Color(0xFF1B5E20)
                                  : Colors.grey.shade300,
                            ),
                          ),
                          showCheckmark: false,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 24.h),

                // FAQs List
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: state.filteredFaqs.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final faq = state.filteredFaqs[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ],
                          border: Border.all(color: Colors.grey.shade100),
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: Text(
                              faq.question,
                              style: AppTextStyle.setPoppinsBlack(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            childrenPadding:
                                EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                faq.answer,
                                style: AppTextStyle.setPoppinsSecondaryText(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
