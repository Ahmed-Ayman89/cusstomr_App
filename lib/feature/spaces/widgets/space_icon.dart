import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpaceIcon extends StatelessWidget {
  final String iconPath;
  final double? width;
  final double? height;
  final BoxFit fit;

  const SpaceIcon({
    super.key,
    required this.iconPath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    if (iconPath.startsWith('assets/') && iconPath.endsWith('.svg')) {
      return SvgPicture.asset(
        iconPath,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return Image.file(
        File(iconPath),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          // Fallback if file not found or invalid
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey,
              size: (width != null && height != null)
                  ? (width! < height! ? width! * 0.5 : height! * 0.5)
                  : 24.r,
            ),
          );
        },
      );
    }
  }
}
