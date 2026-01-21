import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import 'logout_dialog.dart';
import 'personal_info_modal.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background, // Light grey background
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage:
                    const AssetImage('assets/images/avatar_placeholder.png'),
                child: const Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ahmed Omar',
                    style: AppTextStyle.setPoppinsBlack(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '01068551047',
                    style: AppTextStyle.setPoppinsSecondaryText(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: Color(0xFFBDBDBD)),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildMenuItem(
            context,
            title: "My Personal Information",
            subtitle: "My personal information , security and safety",
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const PersonalInfoModal(),
              );
            },
          ),
          SizedBox(height: 8.h),
          _buildMenuItem(
            context,
            title: "Limits",
            subtitle: "Daily, Monthly, etc",
            onTap: () {},
          ),
          SizedBox(height: 8.h),
          _buildMenuItem(
            context,
            title: "Fees",
            subtitle: "Details of Fees Breakdown",
            onTap: () {},
          ),
          SizedBox(height: 8.h),
          _buildMenuItem(
            context,
            title: "Invite Your Friends",
            subtitle: "invite your friend to Grow and Receive a reward",
            onTap: () {},
          ),
          SizedBox(height: 8.h),
          _buildMenuItem(
            context,
            title: "Logout",
            subtitle: "",
            isLogout: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const LogoutDialog(),
              );
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 82.h,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0A000000), // #0000000A
              offset: const Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.setPoppinsBlack(
                      fontSize: 14,
                      fontWeight: isLogout ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.setPoppinsSecondaryText(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 16.r, color: AppColors.neutral400),
          ],
        ),
      ),
    );
  }
}
