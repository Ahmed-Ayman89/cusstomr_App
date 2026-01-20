import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/helper/app_text_style.dart';
import '../data/models/space_model.dart';
import '../manager/space_cubit.dart';

class SpaceSettingsScreen extends StatefulWidget {
  final SpaceModel space;

  const SpaceSettingsScreen({super.key, required this.space});

  @override
  State<SpaceSettingsScreen> createState() => _SpaceSettingsScreenState();
}

class _SpaceSettingsScreenState extends State<SpaceSettingsScreen> {
  late TextEditingController _nameController;
  late TextEditingController _goalController;
  late TextEditingController _deadlineController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.space.name);
    _goalController = TextEditingController(
        text: 'Points ${widget.space.goalAmount?.toInt() ?? 0}');
    _deadlineController = TextEditingController(
        text: widget.space.deadline != null
            ? _formatDate(widget.space.deadline!)
            : '');
  }

  String _formatDate(DateTime date) {
    // 30 Dec 2025
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _goalController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  void _attemptDelete() {
    if (widget.space.currentAmount > 0) {
      // Show blocking dialog
      showDialog(
        context: context,
        builder: (ctx) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Warning Icon
                Icon(Icons.warning_amber_rounded,
                    size: 48.r,
                    color: const Color(0xFF1B4D3E)), // Dark green/teal icon
                SizedBox(height: 16.h),
                Text(
                  "Can't Delete Space",
                  style: AppTextStyle.setPoppinsBlack(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Move the existing point to another space or main account to be able to delete this space",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.setPoppinsSecondaryText(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF008751), // Green text
                    ),
                    child: Text(
                      'Dismiss',
                      style: AppTextStyle.setPoppinsTextStyle(
                          color: const Color(0xFF008751),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Delete Space'),
          content: const Text('Are you sure you want to delete this space?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                context.read<SpaceCubit>().deleteSpace(widget.space.id);
                Navigator.pop(ctx); // Close dialog
                Navigator.pop(context); // Close Settings
                Navigator.pop(context); // Close Detail (Back to Spaces)
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.r, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Seeting', // As per design
          style: AppTextStyle.setPoppinsBlack(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    // Hero Icon
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.r),
                            child: SvgPicture.asset(widget.space.iconAsset,
                                height: 120.h),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: const BoxDecoration(
                                color: Color(0xFF008751),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.perm_media_outlined,
                                  color: Colors.white, size: 16.r),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),

                    Text('Your Space',
                        style: AppTextStyle.setPoppinsSecondaryText(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    SizedBox(height: 16.h),

                    _buildField('Space Name', _nameController),
                    SizedBox(height: 16.h),
                    _buildField('Saving Goal', _goalController),
                    SizedBox(height: 16.h),
                    _buildField('Deadline', _deadlineController),

                    SizedBox(height: 48.h),

                    // Delete Button
                    InkWell(
                      onTap: _attemptDelete,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF5F5),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline,
                                color: Colors.red, size: 24.r),
                            SizedBox(width: 12.w),
                            Text(
                              'Delete Space',
                              style: AppTextStyle.setPoppinsTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: AppTextStyle.setPoppinsSecondaryText(
                            fontSize: 12, fontWeight: FontWeight.w400)
                        .copyWith(color: Colors.grey.shade500)),
                SizedBox(height: 4.h),
                Text(controller.text,
                    style: AppTextStyle.setPoppinsBlack(
                        fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          // Edit Icon
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF008751), width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.edit_outlined,
                color: Color(0xFF008751), size: 16),
          ),
        ],
      ),
    );
  }
}
