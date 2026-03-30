import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:market_ease/core/data_source/remote/api_service.dart';
import 'package:market_ease/core/routes/app_routes.dart';
import 'package:market_ease/core/shared_widgets/custom_text_form_field.dart';
import 'package:market_ease/core/shared_widgets/product_loading.dart';
import 'package:market_ease/features/auth/login/view/widgets/dont_have_account.dart';
import 'package:market_ease/features/auth/login/view/widgets/google_auth_widget.dart';
import 'package:market_ease/features/auth/login/view/widgets/or_login_with.dart';
import 'package:market_ease/features/auth/login/view_model/login_cubit.dart';
import 'package:market_ease/features/auth/shared_widgets/custom_auth_button.dart';
import '../../../../core/shared_widgets/snack_bar.dart';
import '../../../../core/theme/light_colors.dart';
import '../../../../generated/assets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(ApiService()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.only(top: 44.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Form(
                    autovalidateMode: autoValidateMode,
                    key: _formKey,
                    child: BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is LoginSuccess) {
                          SnackBarCustom.showSuccessSnackBar(
                            context,
                            "Authenticated successfully",
                          );
                          context.go(AppRoutes.kMainScreen);
                        } else if (state is LoginFailure) {
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
                            SvgPicture.asset(Assets.imagesMarketEaseLogo),
                            SizedBox(height: 8),
                            Text(
                              "MarketEase",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Elevate your shopping experience with MarketEase",
                              style: Theme.of(context).textTheme.displaySmall!
                                  .copyWith(color: LightColors.textColor),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: 340.w,
                              decoration: BoxDecoration(
                                color: Color(0xFF0F172A),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(32),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome Back",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Please enter your details to sign in",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                            color: LightColors.textColor,
                                          ),
                                    ),
                                    SizedBox(height: 32),
                                    CustomTextFormField(
                                      prefixIcon: Icon(Icons.email),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a valid email address";
                                        }

                                        final emailRegex = RegExp(
                                          r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
                                        );
                                        if (!emailRegex.hasMatch(value)) {
                                          return 'Please enter a valid email address';
                                        }
                                        return null;
                                      },
                                      controller: emailController,
                                      hintText: "example@example.com",
                                      title: "Email Address",
                                      autoValidateMode: autoValidateMode,
                                    ),
                                    SizedBox(height: 16),
                                    CustomTextFormField(
                                      obSecure: true,
                                      prefixIcon: Icon(Icons.lock),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a valid password";
                                        }
                                        if (value.length < 6) {
                                          return "Password must be at least 6 characters";
                                        }
                                        final passwordRegex = RegExp(
                                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$',
                                        );
                                        if (!passwordRegex.hasMatch(value)) {
                                          return "Please enter a valid password";
                                        }
                                        return null;
                                      },
                                      controller: passwordController,
                                      hintText: "*******",
                                      title: "Password",
                                      autoValidateMode: autoValidateMode,
                                    ),
                                    SizedBox(height: 24),
                                    state is LoginLoading
                                        ? Center(
                                            child: SizedBox(
                                              height: 52.h,
                                              child: ProductLoading(),
                                            ),
                                          )
                                        : CustomAuthButton(
                                            title: "Sign In",
                                            onPressed: () {
                                              autoValidateMode =
                                                  AutovalidateMode.always;
                                              setState(() {});
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<LoginCubit>()
                                                    .login(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                    );
                                              }
                                            },
                                          ),
                                    SizedBox(height: 16),
                                    OrLoginWith(),
                                    SizedBox(height: 16),
                                    GoogleAuthWidget(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            DoNotHaveAccount(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
