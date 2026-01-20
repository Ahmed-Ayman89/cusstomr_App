import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../auth/widgets/Cusstom_btn.dart';
import '../../auth/widgets/custom_text_field.dart';
import '../../../core/helper/app_text_style.dart';
import '../data/models/space_model.dart';

class SetGoalScreen extends StatefulWidget {
  final SpaceModel space;

  const SetGoalScreen({super.key, required this.space});

  @override
  State<SetGoalScreen> createState() => _SetGoalScreenState();
}

class _SetGoalScreenState extends State<SetGoalScreen> {
  final TextEditingController _goalController = TextEditingController();

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
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
          'Set Goal',
          style: AppTextStyle.setPoppinsBlack(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set a savings goal for ${widget.space.name}',
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Define your target amount to help track your progress',
                style: AppTextStyle.setPoppinsSecondaryText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'Goal Amount',
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                hintText: 'Enter goal amount',
                controller: _goalController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8.h),
              Text(
                'Current balance: EGP ${widget.space.currentAmount.toStringAsFixed(2)}',
                style: AppTextStyle.setPoppinsSecondaryText(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  title: 'Set Goal',
                  onPressed: () {
                    final goalAmount = double.tryParse(_goalController.text);
                    if (goalAmount != null && goalAmount > 0) {
                      // Navigate back with the goal
                      Navigator.pop(context, goalAmount);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid amount'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  color: const Color(0xFF008751),
                  textColor: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
