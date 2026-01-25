import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/app_text_style.dart';
import '../data/models/space_model.dart';

class SpaceGridCard extends StatelessWidget {
  final SpaceModel space;
  final VoidCallback onTap;

  const SpaceGridCard({
    super.key,
    required this.space,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Using white background for the card to let the icon stand out
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon (Larger and original colors)
            Center(
              child: SizedBox(
                width: 60.w,
                height: 60.h,
                child: Icon(Icons.savings, size: 40.r, color: Colors.green),
              ),
            ),
            const Spacer(),
            // Space Name
            Text(
              space.name,
              style: AppTextStyle.setPoppinsBlack(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            // Points
            Text(
              'Points ${space.balance}',
              style: AppTextStyle.setPoppinsSecondaryText(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
