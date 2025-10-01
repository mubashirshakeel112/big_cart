import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget? content;
  final TextStyle? textStyle;
  final Color? bgColor;
  final EdgeInsets? insetPadding;
  final EdgeInsets? contentPadding;
  final EdgeInsets? titlePadding;
  const CustomDialog({super.key, required this.title, this.content, this.textStyle, this.bgColor, this.insetPadding, this.contentPadding, this.titlePadding,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: insetPadding ?? EdgeInsets.zero,
      backgroundColor: bgColor ?? AppColors.white,
      contentPadding: contentPadding,
      titlePadding: titlePadding,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Center(
        child: Text(
          title,
          style: textStyle ?? interBold.copyWith(fontSize: 18, color: AppColors.black),
        ),
      ),
      content: content,
    );
  }
}