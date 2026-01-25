import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/auth/screens/sign_up_screen.dart';
import 'package:flutter_application_1/feature/auth/screens/verification_code_screen.dart';
import 'package:flutter_application_1/feature/auth/widgets/custom_text_field.dart';
import 'package:flutter_application_1/feature/auth/widgets/Cusstom_btn.dart';
import 'package:flutter_application_1/core/helper/app_text_style.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_application_1/feature/auth/data/repositories/auth_repository.dart';
import 'package:flutter_application_1/core/helper/snackbar_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
                builder: (context) => const VerificationCodeScreen(
                  nextStep: VerificationNextStep.login,
                ),
              ),
            );
          } else if (state is AuthFailure) {
            SnackBarHelper.showError(context, state.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Login',
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
                            'assets/login.svg',
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
                          controller: _phoneController,
                          hintText: 'Phone Number',
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
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
                                    context
                                        .read<AuthCubit>()
                                        .loginInit(_phoneController.text);
                                  }
                                },
                              ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have An Account? ',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to sign up
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign up',
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
