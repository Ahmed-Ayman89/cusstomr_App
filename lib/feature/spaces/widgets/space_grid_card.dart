import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                child: _buildIcon(),
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
              'Points ${space.currentAmount.toStringAsFixed(0)}',
              style: AppTextStyle.setPoppinsSecondaryText(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (space.hasGoal && space.goalAmount != null) ...[
              SizedBox(height: 8.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: space.progress,
                  backgroundColor: Colors.grey.shade100,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFF008751)),
                  minHeight: 4.h,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (space.iconAsset.endsWith('.svg')) {
      return SvgPicture.asset(
        space.iconAsset,
        fit: BoxFit.contain,
        // No ColorFilter to preserve original colors
      );
    } else {
      return Image.asset(
        space.iconAsset,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.savings_outlined,
          color: const Color(0xFF008751),
          size: 40.r,
        ),
      );
    }
  }
}
