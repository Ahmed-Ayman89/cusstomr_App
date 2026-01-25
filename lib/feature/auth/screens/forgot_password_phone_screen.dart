import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/feature/auth/data/repositories/auth_repository.dart';
import 'package:flutter_application_1/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_application_1/feature/auth/screens/verification_code_screen.dart';
import 'package:flutter_application_1/feature/auth/widgets/Cusstom_btn.dart';
import 'package:flutter_application_1/core/helper/app_text_style.dart';
import 'package:flutter_application_1/core/helper/snackbar_helper.dart';

import '../../../../core/theme/app_colors.dart';

class ForgotPasswordPhoneScreen extends StatefulWidget {
  const ForgotPasswordPhoneScreen({super.key});

  @override
  State<ForgotPasswordPhoneScreen> createState() =>
      _ForgotPasswordPhoneScreenState();
}

class _ForgotPasswordPhoneScreenState extends State<ForgotPasswordPhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepository: AuthRepository()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            SnackBarHelper.showSuccess(context, state.message);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VerificationCodeScreen(
                  nextStep: VerificationNextStep.resetPasscode,
                ),
              ),
            );
          } else if (state is AuthFailure) {
            SnackBarHelper.showError(context, state.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                "Mobile number",
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    // Illustration
                    Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.phonelink_lock,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    Text(
                      'Enter the mobile number to log in\nagain',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.setPoppinsSecondaryText(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ).copyWith(height: 1.5),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone_outlined),
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    state is AuthLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            title: 'Continue',
                            onPressed: () {
                              final phone = _phoneController.text.trim();
                              if (phone.isNotEmpty) {
                                context.read<AuthCubit>().loginInit(phone);
                              } else {
                                SnackBarHelper.showWarning(
                                    context, "Please enter phone number");
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
