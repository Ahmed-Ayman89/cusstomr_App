import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../auth/widgets/Cusstom_btn.dart';
import '../../auth/widgets/custom_text_field.dart';
import '../../../core/helper/app_text_style.dart';
import '../data/models/space_model.dart';

class SetGoalBottomSheet extends StatefulWidget {
  final SpaceModel tempSpace;

  const SetGoalBottomSheet({super.key, required this.tempSpace});

  @override
  State<SetGoalBottomSheet> createState() => _SetGoalBottomSheetState();
}

class _SetGoalBottomSheetState extends State<SetGoalBottomSheet> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF008751),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF008751),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _finish(bool hasGoal) {
    double? goalAmount;
    if (hasGoal) {
      if (_amountController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a goal amount')),
        );
        return;
      }
      goalAmount = double.tryParse(_amountController.text.trim());
      if (goalAmount == null || goalAmount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid amount')),
        );
        return;
      }
    }

    final finalSpace = widget.tempSpace.copyWith(
      hasGoal: hasGoal,
      goalAmount: goalAmount,
      deadline: _selectedDate,
    );

    Navigator.pop(context, finalSpace);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 24.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add your saving goal',
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.close, size: 24.r, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Text(
            'Points Saving goal',
            style: AppTextStyle.setPoppinsBlack(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            hintText: '0 Points',
            controller: _amountController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 24.h),
          Text(
            'Deadline',
            style: AppTextStyle.setPoppinsBlack(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          InkWell(
            onTap: () => _selectDate(context),
            child: IgnorePointer(
              child: CustomTextField(
                hintText: 'dd/mm/yyyy',
                controller: _dateController,
                suffixIcon: Icon(Icons.calendar_today_outlined,
                    size: 20.r, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          CustomButton(
            title: 'Save',
            onPressed: () => _finish(true),
            color: const Color(0xFF008751),
            textColor: Colors.white,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton(
              onPressed: () => _finish(false),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Skip for now',
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
