import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/helper/app_text_style.dart';

class GlowTextWidget extends StatelessWidget {
  final Animation<double> fadeAnimation;

  const GlowTextWidget({
    super.key,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Text(
        'Glow',
        style: AppTextStyle.setPoppinsPrimaryText(
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ).copyWith(
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
