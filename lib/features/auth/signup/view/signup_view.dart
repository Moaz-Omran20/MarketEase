import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_ease/core/data_source/remote/api_service.dart';
import 'package:market_ease/core/shared_widgets/custom_text_form_field.dart';
import 'package:market_ease/core/theme/light_colors.dart';
import 'package:market_ease/features/auth/shared_widgets/custom_auth_button.dart';
import 'package:market_ease/features/auth/signup/view/widgets/already_have_account.dart';
import 'package:market_ease/features/auth/signup/view_model/signup_cubit.dart';

import '../../../../core/shared_widgets/snack_bar.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(ApiService()),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: autoValidateMode,
              key: _formKey,
              child: BlocConsumer<SignupCubit, SignupState>(
                listener: (context, state) {
                  if (state is SignupSuccess) {
                    SnackBarCustom.showSuccessSnackBar(
                      context,
                      "Account Created Successfully ",
                    );
                    emailController.clear();
                    fullNameController.clear();
                    passwordController.clear();
                    confirmPasswordController.clear();
                    phoneController.clear();
                    autoValidateMode = AutovalidateMode.disabled;
                  } else if (state is SignupError) {
                    SnackBarCustom.showFailureSnackBar(
                      context,
                      state.errorMessage,
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Create Account",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Join MarketEase for a premium shopping experience",
                        style: Theme.of(context).textTheme.displaySmall!
                            .copyWith(color: LightColors.textColor),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your full name";
                          }
                          final nameRegex = RegExp(
                            r"^[a-zA-Z]{2,}(?: [a-zA-Z]+){1,}$",
                          );
                          if (!nameRegex.hasMatch(value.trim())) {
                            return "Please enter at least first and last name";
                          }
                          return null;
                        },
                        controller: fullNameController,
                        hintText: "Moaz Omran",
                        title: "Full Name",
                        autoValidateMode: autoValidateMode,
                        prefixIcon: const Icon(Icons.person),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter an email address";
                          }
                          final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        controller: emailController,
                        hintText: "example@example.com",
                        title: "Email",
                        autoValidateMode: autoValidateMode,
                        prefixIcon: const Icon(Icons.email),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: phoneController,
                        hintText: "01000000000",
                        title: "Phone Number",
                        keyboardType: TextInputType.phone,
                        autoValidateMode: autoValidateMode,
                        prefixIcon: const Icon(Icons.phone),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your phone number";
                          }
                          final phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
                          if (!phoneRegex.hasMatch(value)) {
                            return "Must be Egypt phone number with 11 digits";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        obSecure: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password";
                          }
                          if (value.length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          final passwordRegex = RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$',
                          );
                          if (!passwordRegex.hasMatch(value)) {
                            return "Must contain uppercase, lowercase, number and special character";
                          }
                          return null;
                        },
                        controller: passwordController,
                        hintText: "********",
                        title: "Password",
                        autoValidateMode: autoValidateMode,
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        obSecure: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          }
                          if (value != passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        controller: confirmPasswordController,
                        hintText: "********",
                        title: "Confirm Password",
                        autoValidateMode: autoValidateMode,
                        prefixIcon: const Icon(Icons.library_add_check_rounded),
                      ),
                      const SizedBox(height: 32),
                      if (state is SignupLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        CustomAuthButton(
                          title: "Sign Up",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignupCubit>().signup(
                                name: fullNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                                phone: phoneController.text,
                              );
                            } else {
                              setState(() {
                                autoValidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                        ),
                      const SizedBox(height: 16),
                      const AlreadyHaveAccount(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
