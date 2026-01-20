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
    final color = Color(int.parse(space.color.replaceAll('#', '0xFF')));
    final isMainAccount = space.id == '1'; // Assuming '1' is Main Account

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: isMainAccount ? null : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: isMainAccount
              ? null
              : Border.all(
                  color: color.withOpacity(0.3),
                  width: 1,
                ),
          image: isMainAccount
              ? const DecorationImage(
                  image: AssetImage('assets/onboarding/card_bg.png'),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: isMainAccount ? Colors.white.withOpacity(0.2) : color,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: _buildIcon(isMainAccount, color),
              ),
            ),
            const Spacer(),
            // Space Name
            Text(
              space.name,
              style: AppTextStyle.setPoppinsTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isMainAccount ? Colors.white : Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            // Points
            Text(
              'Points ${space.currentAmount.toStringAsFixed(0)}',
              style: AppTextStyle.setPoppinsTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isMainAccount
                    ? Colors.white.withOpacity(0.7)
                    : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(bool isMainAccount, Color color) {
    if (space.iconAsset.endsWith('.svg')) {
      return SvgPicture.asset(
        space.iconAsset,
        width: 20.w,
        height: 20.h,
        colorFilter: ColorFilter.mode(
          isMainAccount ? Colors.white : Colors.white,
          BlendMode.srcIn,
        ),
      );
    } else {
      return Image.asset(
        space.iconAsset,
        width: 20.w,
        height: 20.h,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.savings_outlined,
          color: Colors.white,
          size: 18.r,
        ),
      );
    }
  }
}
