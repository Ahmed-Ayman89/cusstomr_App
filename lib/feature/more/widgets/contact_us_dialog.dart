import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/router/routes.dart';
import '../../../core/helper/app_text_style.dart';

class ContactUsDialog extends StatelessWidget {
  const ContactUsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(24.r, 24.r, 24.r, 32.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contact Us',
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child:
                    Icon(Icons.cancel, color: Colors.grey.shade300, size: 24.r),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'We are here to help you! Choose the best way to contact us through whatsapp or request a call',
            style: AppTextStyle.setPoppinsSecondaryText(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 24.h),

          // Request a call
          _buildActionItem(
            onTap: () {
              Navigator.pushNamed(context, Routes.requestCallScreen);
            },
            icon: SvgPicture.asset(
              'assets/icons/call.svg',
              height: 40.r,
              width: 40.r,
              fit: BoxFit.scaleDown,
            ),
            title: 'Request a call',
            subtitle: 'Let us call you to answer your question',
            trailing:
                Icon(Icons.arrow_forward_ios, size: 20.r, color: Colors.black),
          ),

          SizedBox(height: 16.h),

          // WhatsApp
          _buildActionItem(
            onTap: () async {},
            title: 'Contact us via Whatsapp',
            trailing: SvgPicture.asset(
              'assets/icons/whatsapp-filled.svg',
              color: const Color(0xFF25D366),
              height: 24.r,
              width: 24.r,
              fit: BoxFit.scaleDown,
            ),
            isWhatsApp: true,
          ),

          SizedBox(height: 32.h),

          // Social Media
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.camera_alt,
                  const Color(0xFFE4405F)), // Instagram placeholder
              SizedBox(width: 16.w),
              _buildSocialIcon(Icons.close, Colors.black), // X placeholder
              SizedBox(width: 16.w),
              _buildSocialIcon(Icons.facebook,
                  const Color(0xFF1877F2)), // Facebook placeholder
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required VoidCallback onTap,
    String? title,
    String? subtitle,
    Widget? icon,
    Widget? trailing,
    bool isWhatsApp = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: icon,
              ),
              SizedBox(width: 16.w),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title,
                      style: AppTextStyle.setPoppinsBlack(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: AppTextStyle.setPoppinsSecondaryText(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color(0xFF00695C), // Dark green background
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20.r),
    );
  }
}
