import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/app_text_style.dart';

class RequestCallScreen extends StatefulWidget {
  const RequestCallScreen({super.key});

  @override
  State<RequestCallScreen> createState() => _RequestCallScreenState();
}

class _RequestCallScreenState extends State<RequestCallScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
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
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.r),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Request a Call',
          style: AppTextStyle.setPoppinsBlack(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field
            Text(
              'Name',
              style: AppTextStyle.setPoppinsBlack(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                hintStyle: AppTextStyle.setPoppinsLightGray(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFF00695C)),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Time Field
            Text(
              'When would you like us to call',
              style: AppTextStyle.setPoppinsBlack(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _timeController,
              readOnly: true,
              onTap: () => _selectTime(context),
              decoration: InputDecoration(
                hintText: '10:00 AM',
                hintStyle: AppTextStyle.setPoppinsLightGray(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFF00695C)),
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  // Handle submit
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary800, // Dark green
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Submit Request',
                  style: AppTextStyle.setPoppinsWhite(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
