import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/presentation/signup/notifier/signup_notifier.dart';
import 'package:big_cart/widgets/custom_button.dart';
import 'package:big_cart/widgets/custom_loader.dart';
import 'package:big_cart/widgets/custom_snack_bar.dart';
import 'package:big_cart/widgets/custom_stack.dart';
import 'package:big_cart/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupView extends StatefulWidget {
  static const String id = '/signup_view';

  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool isPasswordShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(signupProvider);
          final notifier = ref.read(signupProvider.notifier);
          return CustomStack(
            height: MediaQuery.of(context).size.height * 0.53,
            bgImage: Strings.signup,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    children: [
                      SizedBox(height: 30),
                      Text('Create account', style: interSemiBold.copyWith(fontSize: 25, color: AppColors.black)),
                      SizedBox(height: 2),
                      Text('Quickly create account', style: interRegular),
                      SizedBox(height: 26),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        hintText: 'Name',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 28, right: 12),
                          child: SvgPicture.asset(Strings.profile),
                        ),
                        onChanged: (value) {
                          notifier.setName(value);
                        },
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
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
                        keyboardType: TextInputType.phone,
                        hintText: 'Phone',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 28, right: 12),
                          child: SvgPicture.asset(Strings.telephone),
                        ),
                        onChanged: (value) {
                          notifier.setPhone(value);
                        },
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                        hintText: 'Password',
                        obscureText: isPasswordShow ? false : true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 28, right: 12),
                          child: SvgPicture.asset(Strings.lock),
                        ),
                        isSuffixIcon: true,
                        suffixIcon: isPasswordShow ? Icons.visibility_off : Icons.visibility,
                        onSuffixIconPressed: () {
                          setState(() {
                            isPasswordShow = !isPasswordShow;
                          });
                        },
                        onChanged: (value) {
                          notifier.setPassword(value);
                        },
                      ),
                      SizedBox(height: 17),
                      state.isLoading
                          ? CustomLoader(title: 'creating your account...')
                          : PrimaryButton(
                              onPressed: () {
                                if (notifier.isFormValid) {
                                  notifier.signup(context);
                                } else {
                                  CustomSnackBar.missingInfo(
                                    context: context,
                                    title: 'Missing Info',
                                    message: 'Please fill all the required fields',
                                  );
                                }
                              },
                              title: 'Signup',
                            ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account ? ', style: interLight),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text('Login', style: interMedium.copyWith(color: AppColors.black)),
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
