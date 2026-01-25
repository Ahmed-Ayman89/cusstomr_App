import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helper/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import 'dart:math' as math;

class BalanceCard extends StatefulWidget {
  final num points;
  final String? balance;

  const BalanceCard({super.key, this.points = 25890, this.balance});

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 165.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF187259),
            Color(0xFF022E22),
          ],
          stops: [0.0, 1.0],
          transform: math.pi != 0
              ? GradientRotation(101.99 * (math.pi / 180))
              : null, // 101.99 deg
        ),
      ),
      child: Stack(
        children: [
          // Background Decorative Arcs
          Positioned(
            top: -20.h,
            right: -20.w,
            child: Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
          ),
          Positioned(
            top: -50.h,
            right: -5.w,
            child: Container(
              width: 200.w,
              height: 200.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your Balance:",
                        style: AppTextStyle.setPoppinsWhite(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      child: SvgPicture.asset(
                        _isVisible
                            ? 'assets/icons/eye-slash.svg'
                            : 'assets/icons/vuesax.svg',
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  _isVisible ? '${widget.balance ?? '0.00'}' : "***********",
                  style: AppTextStyle.setPoppinsWhite(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SvgPicture.asset(
                  'assets/Vector.svg',
                  height: 28.h,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
