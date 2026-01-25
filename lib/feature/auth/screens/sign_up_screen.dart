import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/auth/screens/verification_code_screen.dart';
import 'package:flutter_application_1/feature/auth/screens/login_screen.dart';
import 'package:flutter_application_1/feature/auth/widgets/custom_text_field.dart';
import 'package:flutter_application_1/feature/auth/widgets/Cusstom_btn.dart';
import 'package:flutter_application_1/core/helper/app_text_style.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_application_1/feature/auth/data/repositories/auth_repository.dart';
import 'package:flutter_application_1/core/helper/snackbar_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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
                builder: (context) => const VerificationCodeScreen(),
              ),
            );
          } else if (state is AuthFailure) {
            SnackBarHelper.showError(context, state.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          'Sign up',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.setPoppinsBlack(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Placeholder for illustration
                        Center(
                          child: SvgPicture.asset(
                            'assets/sign in.svg',
                            height: 200,
                            width: 200,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Enter your Mobile Number to Continue',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.setPoppinsSecondaryText(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          hintText: 'Full Name',
                          prefixIcon: Icons.person_outline,
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hintText: 'Phone Number',
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (value.length < 10) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        state is AuthLoading
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                title: 'Send Code',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().registerInit(
                                          fullName: _nameController.text,
                                          phone: _phoneController.text,
                                        );
                                  }
                                },
                              ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already Have An Account? ',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to sign in
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
                                style: AppTextStyle.setPoppinsBrandPrimary(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
