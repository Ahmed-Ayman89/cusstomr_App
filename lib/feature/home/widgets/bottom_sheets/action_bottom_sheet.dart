import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/app_text_style.dart';

class ActionBottomSheet extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ActionBottomSheet({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 20.r,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }
}

class ActionItemWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final String? subtitle;
  final String? statusText;
  final Color? statusColor;
  final Color? iconBackgroundColor;
  final VoidCallback onTap;
  final bool isSoon;

  const ActionItemWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.statusText,
    this.statusColor,
    this.iconBackgroundColor,
    required this.onTap,
    this.isSoon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 79.h,
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(width: 1, color: Colors.grey.shade400),
        boxShadow: const [
          BoxShadow(
            color: Color(0x82C3BEBE),
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
        child: InkWell(
          onTap: isSoon ? null : onTap,
          borderRadius: BorderRadius.circular(10.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                // Icon Container
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: isSoon
                        ? Colors.grey.shade100
                        : (iconBackgroundColor ?? const Color(0xFFF5F5F7)),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: icon),
                ),
                SizedBox(width: 16.w),
                // Content
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
                        ).copyWith(
                          color: isSoon ? Colors.grey.shade400 : Colors.black,
                          height: 1.1,
                        ),
                      ),
                      if (subtitle != null || statusText != null || isSoon) ...[
                        SizedBox(height: 2.h),
                        if (isSoon)
                          Text('Soon',
                              style: AppTextStyle.setPoppinsSecondaryText(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ))
                        else if (statusText != null)
                          Text(
                            statusText!,
                            style: AppTextStyle.setPoppinsSecondaryText(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ).copyWith(
                              color: statusColor ?? const Color(0xFF4CAF50),
                              height: 1.1,
                            ),
                          )
                        else
                          Text(subtitle!,
                              style: AppTextStyle.setPoppinsSecondaryText(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              )),
                      ],
                    ],
                  ),
                ),
                // Arrow
                if (!isSoon)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.r,
                    color: Colors.black,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
