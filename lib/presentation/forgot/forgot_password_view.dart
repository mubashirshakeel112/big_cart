import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/presentation/forgot/notifier/forgot_password_notifier.dart';
import 'package:big_cart/widgets/custom_app_bar.dart';
import 'package:big_cart/widgets/custom_button.dart';
import 'package:big_cart/widgets/custom_loader.dart';
import 'package:big_cart/widgets/custom_snack_bar.dart';
import 'package:big_cart/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordView extends StatelessWidget {
  static const String id = '/forgot_password_view';
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: PrimaryAppBar(title: 'Password Recovery', statusBarHeight: MediaQuery.of(context).viewPadding.top, bgColor: AppColors.white2,),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(forgotPasswordProvider);
          final notifier = ref.watch(forgotPasswordProvider.notifier);
          return Column(
            children: [
              SizedBox(height: 84,),
              Text('Forgot Password', style: interSemiBold.copyWith(fontSize: 25, color: AppColors.black),),
              SizedBox(height: 13,),
              Text('Lorem ipsum dolor sit amet, consetetur\nsadipscing elitr, sed diam nonumy', style: interMedium.copyWith(fontSize: 15), textAlign: TextAlign.center,),
              SizedBox(height: 44,),
              CustomTextField(
                margin: EdgeInsets.symmetric(horizontal: 17),
                hintText: 'Email Address',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 28, right: 10),
                  child: SvgPicture.asset(Strings.email),
                ),
                onChanged: (value){
                  notifier.setEmail(value);
                },
              ),
              SizedBox(height: 13,),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 17),
                child: state.isLoading ? CustomLoader(title: 'Forgot Password...') : PrimaryButton(onPressed: (){
                  if(state.email.isNotEmpty){
                    notifier.forgotPassword(context);
                  }else{
                    CustomSnackBar.missingInfo(context: context, title: 'Missing Info', message: 'Please fill the required field');
                  }
                }, title: 'Send link',),
              ),
            ],
          );
        }
      ),
    );
  }
}
