import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/app_text_style.dart';

class AboutGrowScreen extends StatelessWidget {
  const AboutGrowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.r),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'About Grow',
          style: AppTextStyle.setPoppinsBlack(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            // Hero Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF00C853),
                    Color(0xFF00695C)
                  ], // Green gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.star,
                        color: const Color(0xFF00695C), size: 24.r),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Our Mission',
                    style: AppTextStyle.setPoppinsWhite(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Building better habits and achieving your goals through simple, consistent steps and rewarding progress.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.setPoppinsWhite(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ).copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Features List
            _buildFeatureCard(
              icon: Icons.auto_awesome, // Sparkle
              title: 'Simple & Effortless',
              description:
                  'Grow turns your spare change, round-ups, and tiny daily amounts into real progress. No complicated decisions, just automatic savings.',
            ),
            _buildFeatureCard(
              icon: Icons.emoji_events_outlined, // Trophy
              title: 'Rewarding Experience',
              description:
                  'Earn points for your actions and track your progress. We celebrate your consistency and encourage smarter saving habits.',
            ),
            _buildFeatureCard(
              icon: Icons.bolt, // Lightning
              title: 'Empowering Your Future',
              description:
                  'Take control of your future without stress. Build stability, unlock opportunities, and feel confident about your journey.',
            ),

            SizedBox(height: 16.h),

            // Footer
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1), // Light teal
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.science,
                        color: const Color(0xFF00695C), size: 24.r),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Join a generation where saving becomes a habit, not a challenge. Every small step counts.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.setPoppinsBlack(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ).copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: const BoxDecoration(
              color: Color(0xFFF5F5F5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF00695C), size: 20.r),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.setPoppinsBlack(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: AppTextStyle.setPoppinsSecondaryText(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ).copyWith(height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
