import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../auth/widgets/Cusstom_btn.dart';
import '../../auth/widgets/custom_text_field.dart';
import '../../../core/helper/app_text_style.dart';
import '../data/models/space_model.dart';

import '../widgets/creation_flow/initial_deposit_modal.dart';
import 'set_goal_screen.dart'; // Still same filename, but class name changed

class CreateSpaceScreen extends StatefulWidget {
  final String? initialName;
  final String? initialIcon;

  const CreateSpaceScreen({
    super.key,
    this.initialName,
    this.initialIcon,
  });

  @override
  State<CreateSpaceScreen> createState() => _CreateSpaceScreenState();
}

class _CreateSpaceScreenState extends State<CreateSpaceScreen> {
  late TextEditingController _nameController;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, String>> _templates = [
    {'name': 'Home', 'icon': 'assets/onboarding/House.svg', 'color': '#E8F5E9'},
    {'name': 'Car', 'icon': 'assets/onboarding/Car.svg', 'color': '#FFF3E0'},
    {
      'name': 'Travel',
      'icon': 'assets/onboarding/plane.svg',
      'color': '#E3F2FD'
    },
    {
      'name': 'Education',
      'icon': 'assets/onboarding/books.svg',
      'color': '#F3E5F5'
    },
    {'name': 'Gifts', 'icon': 'assets/onboarding/gift.svg', 'color': '#FCE4EC'},
    {
      'name':
          'Marriage', // Duplicate name in list, might want to check this later
      'icon': 'assets/onboarding/wedding-rings.svg',
      'color': '#EFEBE9'
    },
  ];

  int _selectedTemplateIndex = 0;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');

    // Find matching template if initialIcon is provided
    if (widget.initialIcon != null) {
      if (widget.initialIcon!.startsWith('assets/')) {
        final index =
            _templates.indexWhere((t) => t['icon'] == widget.initialIcon);
        if (index != -1) {
          _selectedTemplateIndex = index;
        }
      } else {
        // It's a file path
        _pickedImage = File(widget.initialIcon!);
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTemplate = _templates[_selectedTemplateIndex];
    final bgColor =
        Color(int.parse(selectedTemplate['color']!.replaceAll('#', '0xFF')));

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
          'Space ${selectedTemplate['name']}',
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
                    SizedBox(height: 16.h),
                    // Illustration Header
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200.h,
                          decoration: BoxDecoration(
                            color: bgColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Center(
                            child: _pickedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: Image.file(
                                      _pickedImage!,
                                      height: 140.h,
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                : SvgPicture.asset(
                                    selectedTemplate['icon']!,
                                    height: 140.h,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 12.r,
                          right: 12.r,
                          child: InkWell(
                            onTap: _pickImage,
                            child: Container(
                              width: 32.r,
                              height: 32.r,
                              decoration: BoxDecoration(
                                color: const Color(0xFF008751),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Icon(
                                Icons.image_outlined,
                                color: Colors.white,
                                size: 16.r,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),

                    // Input Section
                    Text(
                      'Name your space',
                      style: AppTextStyle.setPoppinsBlack(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    CustomTextField(
                      hintText: 'Enter name space',
                      controller: _nameController,
                    ),
                    SizedBox(height: 24.h),

                    // Template Buttons Row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _templates.asMap().entries.map((entry) {
                          final index = entry.key;
                          final template = entry.value;
                          final isSelected = _selectedTemplateIndex == index;

                          return Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedTemplateIndex = index;
                                  // If user selects a template, reset picked image?
                                  // Maybe keep picked image but update background color?
                                  // For now, let's clear picked image to switch back to template mode
                                  _pickedImage = null;

                                  if (_nameController.text.isEmpty ||
                                      _templates.any((t) =>
                                          t['name'] == _nameController.text)) {
                                    _nameController.text = template['name']!;
                                  }
                                });
                              },
                              borderRadius: BorderRadius.circular(8.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF008751)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF008751)
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                child: Text(
                                  template['name']!,
                                  style: AppTextStyle.setPoppinsTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),

            // Continue Button
            Padding(
              padding: EdgeInsets.all(24.r),
              child: CustomButton(
                title: 'Continue',
                onPressed: () async {
                  if (_nameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a space name'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  final newSpace = SpaceModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _nameController.text.trim(),
                    iconAsset: _pickedImage?.path ?? selectedTemplate['icon']!,
                    currentAmount: 0.0,
                    goalAmount: null,
                    color: '#008751',
                    hasGoal: false,
                  );

                  final result = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) =>
                        SetGoalBottomSheet(tempSpace: newSpace),
                  );

                  if (result != null && context.mounted) {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => InitialDepositModal(
                        spaceName: result.name,
                        spaceIcon: result.iconAsset,
                        onConfirm: (amount) {
                          Navigator.pop(context); // Close InitialDepositModal
                          Navigator.pop(context, result); // Return to dashboard
                        },
                        onSkip: () {
                          Navigator.pop(context); // Close InitialDepositModal
                          Navigator.pop(context, result); // Return to dashboard
                        },
                      ),
                    );
                  }
                },
                color: const Color(0xFF008751),
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
