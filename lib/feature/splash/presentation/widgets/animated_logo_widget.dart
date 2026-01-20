import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedLogoWidget extends StatelessWidget {
  final Animation<double> dropAnimation;
  final Animation<double> bounceAnimation;
  final Animation<double> glowOpacity;

  const AnimatedLogoWidget({
    super.key,
    required this.dropAnimation,
    required this.bounceAnimation,
    required this.glowOpacity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Glow effect behind logo
        Positioned(
          child: FadeTransition(
            opacity: glowOpacity,
            child: SvgPicture.asset(
              'assets/glow.svg',
              width: 120.w,
              height: 120.h,
            ),
          ),
        ),

        // Main logo with drop and bounce animation
        AnimatedBuilder(
          animation: Listenable.merge([dropAnimation, bounceAnimation]),
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                dropAnimation.value + bounceAnimation.value,
              ),
              child: SvgPicture.asset(
                'assets/mainlogo.svg',
                width: 80.w,
                height: 80.h,
              ),
            );
          },
        ),
      ],
    );
  }
}
