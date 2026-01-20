import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/auth/screens/forgot_password_phone_screen.dart';
import 'package:flutter_application_1/feature/auth/widgets/custom_keypad.dart';
import 'package:flutter_application_1/feature/auth/widgets/Cusstom_btn.dart';
import 'package:flutter_application_1/core/helper/app_text_style.dart';
import 'package:flutter_application_1/core/router/routes.dart';

enum PasscodeMode { create, confirm, login }

class PasscodeScreen extends StatefulWidget {
  final PasscodeMode mode;
  final String? previousPasscode; // Used for confirmation check

  const PasscodeScreen({super.key, required this.mode, this.previousPasscode});

  @override
  State<PasscodeScreen> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  String _currentCode = "";
  final int _codeLength = 6;

  void _onKeyPressed(String value) {
    if (_currentCode.length < _codeLength) {
      setState(() {
        _currentCode += value;
      });

      if (_currentCode.length == _codeLength) {
        _handleCompletion();
      }
    }
  }

  void _onDelete() {
    if (_currentCode.isNotEmpty) {
      setState(() {
        _currentCode = _currentCode.substring(0, _currentCode.length - 1);
      });
    }
  }

  void _onClear() {
    setState(() {
      _currentCode = "";
    });
  }

  void _handleCompletion() {
    if (widget.mode == PasscodeMode.create) {
      // Navigate to Confirm Passcode
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PasscodeScreen(
              mode: PasscodeMode.confirm,
              previousPasscode: _currentCode,
            ),
          ),
        );
      });
    } else if (widget.mode == PasscodeMode.confirm) {
      // Validate Confirmation
      if (_currentCode == widget.previousPasscode) {
        // SUCCESS
        _showSuccessDialog();
      } else {
        // ERROR
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passcodes do not match. Please try again.'),
          ),
        );
        setState(() {
          _currentCode = ""; // Clear for retry
        });
      }
    } else if (widget.mode == PasscodeMode.login) {
      // LOGIN LOGIC (Mock)
      if (_currentCode == "123456") {
        // Mock check
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => PackagesPage()), // Home
        //   (route) => false,
        // );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Invalid Passcode.')));
        setState(() {
          _currentCode = "";
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Color(0xFF1B5E20),
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                "Done!",
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Your passcode has been successfully updated",
                textAlign: TextAlign.center,
                style: AppTextStyle.setPoppinsSecondaryText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                title: "OK",
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.homeView,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onForgotPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation"),
        content: const Text(
          "This will log you out of your account to start the passcode reset process",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotPasswordPhoneScreen(),
                ),
              );
            },
            child: Text(
              "OK",
              style: AppTextStyle.setPoppinsBrandPrimary(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = "Create a Passcode";
    if (widget.mode == PasscodeMode.confirm) title = "Confirm a Passcode";
    if (widget.mode == PasscodeMode.login) {
      title = "Hi, Ahmed"; // Hardcoded name for now
    }

    String subtitle = "Create a passcode to keep your wallet\nsafe";
    if (widget.mode == PasscodeMode.login) {
      subtitle = "Enter Passcode to unlock";
    }

    return Scaffold(
      appBar: AppBar(
        leading: widget.mode == PasscodeMode.login
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : // Show back button for Login
            IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
        automaticallyImplyLeading: false, // Control manually
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTextStyle.setPoppinsBlack(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyle.setPoppinsSecondaryText(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 60),

            // Passcode Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _codeLength,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _currentCode.length
                        ? const Color(0xFF1B5E20) // Green
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Keypad
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  CustomKeypad(
                    onKeyPressed: _onKeyPressed,
                    onDelete: _onDelete,
                    onClear: _onClear,
                  ),
                  if (widget.mode == PasscodeMode.login)
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 0),
                      child: Align(
                        alignment: Alignment
                            .centerLeft, // Actually wireframe has it below 7.
                        child: Container(),
                      ),
                    ),
                ],
              ),
            ),
            if (widget.mode == PasscodeMode.login)
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0, left: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: _onForgotPressed,
                    child: Text(
                      "Forgot ?",
                      style: AppTextStyle.setPoppinsBrandPrimary(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
