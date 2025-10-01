import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final Widget? child;
  final double? height;

  const PrimaryButton({super.key, required this.onPressed, this.title, this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.primary2, AppColors.primary],
        ),
        // boxShadow: [
        //   BoxShadow(spreadRadius: 0, blurRadius: 9, offset: Offset(0, 10), color: AppColors.primary.withOpacity(0.25)),
        // ],
      ),
      child: MaterialButton(
        minWidth: double.infinity,
        height: height ?? 60,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide.none),
        elevation: 0,
        onPressed: onPressed,
        child: child ?? Text(title ?? '', style: interSemiBold.copyWith(color: AppColors.white)),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final Widget? child;
  final double? height;

  const SecondaryButton({super.key, required this.onPressed, this.title, this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: height ?? 45,
      shape: RoundedRectangleBorder(),
      color: AppColors.white,
      elevation: 0,
      onPressed: onPressed,
      child:
          child ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Strings.shoppingBag),
              SizedBox(width: 10),
              Text(title ?? '', style: interMedium.copyWith(fontSize: 12, color: AppColors.black)),
            ],
          ),
    );
  }
}
