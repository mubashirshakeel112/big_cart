import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/presentation/forgot/forgot_password_view.dart';
import 'package:big_cart/presentation/login/notifier/login_notifier.dart';
import 'package:big_cart/presentation/signup/signup_view.dart';
import 'package:big_cart/widgets/custom_button.dart';
import 'package:big_cart/widgets/custom_loader.dart';
import 'package:big_cart/widgets/custom_snack_bar.dart';
import 'package:big_cart/widgets/custom_stack.dart';
import 'package:big_cart/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  static const String id = '/login_view';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isSelected = false;
  bool isPasswordShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(loginProvider);
          final notifier = ref.read(loginProvider.notifier);
          return CustomStack(
            bgImage: Strings.login,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    children: [
                      SizedBox(height: 30),
                      Text('Welcome back !', style: interSemiBold.copyWith(fontSize: 25, color: AppColors.black)),
                      SizedBox(height: 2),
                      Text('Sign in to your account', style: interRegular),
                      SizedBox(height: 26),
                      CustomTextField(
                        hintText: 'Email Address',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 28, right: 12),
                          child: SvgPicture.asset(Strings.email),
                        ),
                        onChanged: (value) {
                          notifier.setEmail(value);
                        },
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                        hintText: 'Password',
                        obscureText: !isPasswordShow ? true : false,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 28, right: 12),
                          child: SvgPicture.asset(Strings.lock),
                        ),
                        isSuffixIcon: true,
                        suffixIcon: !isPasswordShow ? Icons.visibility : Icons.visibility_off,
                        onSuffixIconPressed: () {
                          setState(() {
                            isPasswordShow = !isPasswordShow;
                          });
                        },
                        onChanged: (value) {
                          notifier.setPassword(value);
                        },
                      ),
                      SizedBox(height: 21),
                      Row(
                        children: [
                          IconButton(
                            iconSize: 40,
                            padding: EdgeInsets.zero,
                            splashRadius: 20,
                            onPressed: () {
                              setState(() {
                                isSelected = !isSelected;
                              });
                            },
                            icon: SvgPicture.asset(
                              isSelected ? Strings.toggleFill : Strings.toggleOutline,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(child: Text('Remember me', style: interMedium)),
                          GestureDetector(
                            onTap: () {
                              if (isSelected) {
                                Navigator.pushNamed(context, ForgotPasswordView.id);
                              } else {
                                CustomSnackBar.missingInfo(
                                  context: context,
                                  title: 'Warning',
                                  message: 'Please enable remember me',
                                );
                              }
                            },
                            child: Text('Forgot password?', style: interMedium.copyWith(color: AppColors.blue)),
                          ),
                        ],
                      ),
                      SizedBox(height: 17),
                      state.isLoading
                          ? CustomLoader(title: 'Logging...')
                          : PrimaryButton(
                              onPressed: () {
                                if (notifier.isFormValid) {
                                  notifier.login(context);
                                } else {
                                  CustomSnackBar.missingInfo(
                                    context: context,
                                    title: 'Missing Info',
                                    message: 'Please fill all the required filled',
                                  );
                                }
                              },
                              title: 'Login',
                            ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don’t have an account ? ', style: interLight),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SignupView.id);
                            },
                            child: Text('Sign up', style: interMedium.copyWith(color: AppColors.black)),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
