import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/app_text_style.dart';

class TransactionHistoryItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String points;
  final Widget icon;
  final bool? isIncoming;

  const TransactionHistoryItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.icon,
    this.isIncoming,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: const Color(0x82C3BEBE),
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(
          color: const Color(0xFFC3BEBE).withOpacity(0.5),
          width: 1,
        ),
      ),
      color: Colors.white,
      child: Container(
        width: 343.w,
        height: 79.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            // Icon
            icon,
            SizedBox(width: 12.w),
            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.setPoppinsBlack(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(subtitle,
                      style: AppTextStyle.setPoppinsDarkGray(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ),
            // Points
            Align(
              alignment: Alignment.topRight,
              child: Text(
                points,
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ).copyWith(
                  color: isIncoming == true
                      ? const Color(0xFF4CB080) // Green for incoming points
                      : const Color(0xFF1A1A1A), // Dark for outgoing
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const Color brandLightColor = Color(0xFFD8F3DC);
