import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helper/app_text_style.dart';
import '../../../auth/widgets/custom_keypad.dart';
import '../../widgets/space_icon.dart';
import '../../../auth/widgets/Cusstom_btn.dart';
import '../../../../core/router/routes.dart';

class InitialDepositModal extends StatefulWidget {
  final String spaceName;
  final String spaceIcon;
  final Function(double amount) onConfirm;
  final VoidCallback onSkip;

  const InitialDepositModal({
    super.key,
    required this.spaceName,
    required this.spaceIcon,
    required this.onConfirm,
    required this.onSkip,
  });

  @override
  State<InitialDepositModal> createState() => _InitialDepositModalState();
}

class _InitialDepositModalState extends State<InitialDepositModal> {
  int _step = 0; // 0: Intro, 1: Amount Input, 2: Passcode
  final TextEditingController _amountController = TextEditingController();
  String _passcode = '';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountKeypad(String value) {
    setState(() {
      _amountController.text += value;
    });
  }

  void _onAmountBackspace() {
    if (_amountController.text.isNotEmpty) {
      setState(() {
        _amountController.text = _amountController.text
            .substring(0, _amountController.text.length - 1);
      });
    }
  }

  void _onPasscodeKeypad(String value) {
    if (_passcode.length < 6) {
      setState(() {
        _passcode += value;
      });
      if (_passcode.length == 6) {
        _showSuccessDialog();
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF1B5E20), width: 2),
                ),
                child: Icon(
                  Icons.check,
                  color: const Color(0xFF1B5E20),
                  size: 32.r,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Confirm",
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Your Points ${_amountController.text} is on its way to ${widget.spaceName} space",
                textAlign: TextAlign.center,
                style: AppTextStyle.setPoppinsSecondaryText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24.h),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  widget
                      .onConfirm(double.tryParse(_amountController.text) ?? 0);
                },
                child: Text(
                  "OK",
                  style: AppTextStyle.setPoppinsBrandPrimary(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPasscodeBackspace() {
    if (_passcode.isNotEmpty) {
      setState(() {
        _passcode = _passcode.substring(0, _passcode.length - 1);
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
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: _buildStep(),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _buildIntroStep();
      case 1:
        return _buildAmountStep();
      case 2:
        return _buildPasscodeStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildIntroStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader('Add Points to ${widget.spaceName} Space'),
        SizedBox(height: 32.h),

        // Visual Transfer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Main Account
            Column(
              children: [
                Container(
                  width: 100.w,
                  height: 60.h,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B4D3E),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Text('Your Balance',
                          style:
                              TextStyle(color: Colors.white, fontSize: 8.sp)),
                      Spacer(),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Glow',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Text('Main Account',
                    style: AppTextStyle.setPoppinsBlack(
                        fontSize: 12, fontWeight: FontWeight.w500)),
                Text('Points 0',
                    style: AppTextStyle.setPoppinsSecondaryText(
                        fontSize: 10, fontWeight: FontWeight.w400)),
              ],
            ),

            Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.black),

            // Target Space
            Column(
              children: [
                Container(
                  width: 100.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2F1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: _buildSpaceIcon(),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(widget.spaceName,
                    style: AppTextStyle.setPoppinsBlack(
                        fontSize: 12, fontWeight: FontWeight.w500)),
                Text('Points 0',
                    style: AppTextStyle.setPoppinsSecondaryText(
                        fontSize: 10, fontWeight: FontWeight.w400)),
              ],
            ),
          ],
        ),
        SizedBox(height: 48.h),

        // Actions
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: () => setState(() => _step = 1),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF008751),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text(
              'Save', // "Save" implies proceeding to add points per design
              style: AppTextStyle.setPoppinsTextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
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
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text(
              'Skip for now',
              style: AppTextStyle.setPoppinsBlack(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountStep() {
    return Column(
      children: [
        _buildHeader('Add the amount to deposit'),
        Text(
          'Main Account Balance is Points 0',
          style: AppTextStyle.setPoppinsSecondaryText(
              fontSize: 12, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 32.h),

        // Amount Display
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Pts ',
                  style: TextStyle(fontSize: 24.sp, color: Colors.grey)),
              Text(
                _amountController.text.isEmpty ? '0' : _amountController.text,
                style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              // Blinking cursor simulation if needed
              Container(width: 2, height: 30, color: Colors.green),
            ],
          ),
        ),

        SizedBox(height: 32.h),

        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: () {
              if (_amountController.text.isNotEmpty) {
                setState(() => _step = 2);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF008751),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text(
              'Confirm',
              style: AppTextStyle.setPoppinsTextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        // Numeric Keypad
        CustomKeypad(
          onKeyPressed: _onAmountKeypad,
          onDelete: _onAmountBackspace,
          onClear: () {}, // Not needed usually for simple numpad
        ),
      ],
    );
  }

  Widget _buildPasscodeStep() {
    return Column(
      children: [
        _buildHeader('Enter your passcode to\nconfirm', isBackEnabled: true),
        SizedBox(height: 32.h),

        // Passcode Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 12.w,
              height: 12.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index < _passcode.length
                    ? const Color(0xFF008751)
                    : Colors.grey.shade300,
              ),
            );
          }),
        ),

        Expanded(child: SizedBox()),
        CustomKeypad(
          onKeyPressed: _onPasscodeKeypad,
          onDelete: _onPasscodeBackspace,
          onClear: () {},
        ),
      ],
    );
  }

  Widget _buildHeader(String title, {bool isBackEnabled = false}) {
    return Row(
      children: [
        if (isBackEnabled)
          IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 18.sp),
            onPressed: () => setState(() => _step--),
          ),
        Expanded(
          child: Text(
            title,
            textAlign: isBackEnabled ? TextAlign.center : TextAlign.left,
            style: AppTextStyle.setPoppinsBlack(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (!isBackEnabled)
          IconButton(
            icon: Icon(Icons.close, color: Colors.grey.shade400),
            onPressed: widget.onSkip,
          ),
        if (isBackEnabled) SizedBox(width: 48.w), // Balance back button
      ],
    );
  }

  Widget _buildSpaceIcon() {
    return SpaceIcon(
      iconPath: widget.spaceIcon,
      width: 24.w,
      height: 24.w,
    );
  }
}
