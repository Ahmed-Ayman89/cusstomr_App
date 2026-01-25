import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../auth/widgets/Cusstom_btn.dart';
import '../../auth/widgets/custom_text_field.dart';
import '../../../core/helper/app_text_style.dart';
import '../data/models/space_model.dart';
import '../presentation/cubit/spaces_cubit.dart';

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
              child: BlocConsumer<SpacesCubit, SpacesState>(
                  listener: (context, state) {
                if (state is SpacesFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red),
                  );
                } else if (state is SpacesSuccess) {
                  // Or we can rely on list refresh
                  // Assuming CreateSpace refreshes list, we can pop
                  // But we don't have a specific CreateSuccess state.
                  // Let's assume on success of the Future call we handle it?
                  // Actually Cubit emits Loading then Success/Failure.
                  // IMPORTANT: Since SpacesSuccess just holds list, we can't distinguish "Created" vs "Loaded".
                  // So we'll rely on the Future completion inside the button logic IF we awaited, but cubit is void.
                  // The clean way is to listen for success, but let's check if the list contains the new item? No.
                  // We need a specific side effect or event.
                  // For now, let's reset to simple logic: await the cubit call if changed to Future or assume Success if no error state emitted?
                  // Actually, I'll modify Cubit to emit OperationSuccess or similar? No, I want to minimize changes.
                  // Let's assume validation passes in UI.
                }
              }, builder: (context, state) {
                return CustomButton(
                  title: 'Continue',
                  isLoading: state is SpacesLoading,
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

                    // 1. Get Goal & Deadline
                    final tempSpace = SpaceModel(
                      id: 'temp',
                      name: _nameController.text.trim(),
                      balance: '0.00',
                    );

                    final goalResult = await showModalBottomSheet<SpaceModel>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          SetGoalBottomSheet(tempSpace: tempSpace),
                    );

                    if (goalResult == null) return; // User cancelled

                    // 2. Confirm Passcode
                    final passcode = await _showPasscodeDialog(context);
                    if (passcode == null || passcode.isEmpty) return;

                    // 3. Map Icon
                    final selectedTemplate = _templates[_selectedTemplateIndex];
                    String imageKey =
                        selectedTemplate['name']?.toLowerCase() ?? 'home';
                    // API expects: "home", "car", etc.

                    // 4. Call API
                    final targetAmount = goalResult.goalAmount ?? 0.0;
                    final deadline =
                        goalResult.deadlineObj?.toIso8601String() ?? '';
                    // Note: API likely expects YYYY-MM-DD or ISO. User sample showed ISO.

                    if (context.mounted) {
                      await context.read<SpacesCubit>().createSpace(
                            name: goalResult.name,
                            image: imageKey,
                            targetAmount: targetAmount,
                            deadline: deadline,
                            passcode: passcode,
                          );

                      // Check result by checking state? Or assuming success if not failed?
                      // The createSpace in Cubit is Future<void>.
                      // To be safe, look at current state after await.
                      /* 
                            Actually, since createSpace emits States, we can't easily await "Success" in the onPressed 
                            unless we change Cubit to return value. 
                            However, assuming happy path for now: pop if no error.
                         */
                      final currentState = context.read<SpacesCubit>().state;
                      if (currentState is! SpacesFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Space created successfully'),
                                backgroundColor: Color(0xFF008751)));
                        Navigator.pop(context); // Close Screen
                      }
                    }
                  },
                  color: const Color(0xFF008751),
                  textColor: Colors.white,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showPasscodeDialog(BuildContext context) {
    String passcode = '';
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Passcode',
              style: AppTextStyle.setPoppinsBlack(
                  fontSize: 16, fontWeight: FontWeight.w600)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please enter your 6-digit passcode to confirm creation.',
                  style: AppTextStyle.setPoppinsSecondaryText(
                      fontSize: 12, fontWeight: FontWeight.w400)),
              SizedBox(height: 16.h),
              TextField(
                maxLength: 6,
                keyboardType: TextInputType.number,
                obscureText: true,
                onChanged: (value) => passcode = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Passcode',
                  counterText: '',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(color: Colors.grey))),
            TextButton(
              onPressed: () => Navigator.pop(context, passcode),
              child:
                  Text('Confirm', style: TextStyle(color: Color(0xFF008751))),
            ),
          ],
        );
      },
    );
  }
}
