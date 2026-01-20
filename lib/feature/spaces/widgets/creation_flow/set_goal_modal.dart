import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/helper/app_text_style.dart';

class SetGoalModal extends StatefulWidget {
  final Function(double amount, DateTime deadline) onSave;
  final VoidCallback onSkip;

  const SetGoalModal({
    super.key,
    required this.onSave,
    required this.onSkip,
  });

  @override
  State<SetGoalModal> createState() => _SetGoalModalState();
}

class _SetGoalModalState extends State<SetGoalModal> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _amountController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _deadlineController.text = DateFormat('d/M/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
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
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.grey.shade400),
                onPressed: widget.onSkip,
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Amount Input
          Text(
            'Points Saving goal',
            style: AppTextStyle.setPoppinsBlack(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '0 Points',
              hintStyle: TextStyle(color: Colors.grey.shade400),
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
                borderSide: const BorderSide(color: Color(0xFF008751)),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Deadline Input
          Text(
            'Deadline',
            style: AppTextStyle.setPoppinsBlack(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          InkWell(
            onTap: _selectDate,
            child: IgnorePointer(
              child: TextField(
                controller: _deadlineController,
                decoration: InputDecoration(
                  hintText: 'd/m/yyyy',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
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
                    borderSide: const BorderSide(color: Color(0xFF008751)),
                  ),
                  suffixIcon: Icon(Icons.calendar_today,
                      color: Colors.grey.shade400, size: 20.sp),
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),

          // Actions
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(_amountController.text);
                if (amount != null && _selectedDate != null) {
                  widget.onSave(amount, _selectedDate!);
                } else {
                  // Optional: User feedback if empty
                  // For now assuming validation can be sloppy or user must input
                  if (amount == null) return;
                  if (_selectedDate == null) return;
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF008751),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Save',
                style: AppTextStyle.setPoppinsTextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton(
              onPressed: widget.onSkip,
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
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
