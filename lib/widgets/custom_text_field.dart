import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final bool filled;
  final Color? fillColor;
  final bool isSuffixIcon;
  final String? initialValue;
  final TextEditingController? controller;
  final VoidCallback? onSuffixIconPressed;
  final Function(String)? onChanged;
  final TextStyle? hintStyle;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final EdgeInsets? margin;
  final Color? cursorColor;

  const CustomTextField({super.key, this.hintText, this.prefixIcon, this.suffixIcon ,  this.filled = true, this.fillColor,  this.isSuffixIcon = false, this.hintStyle, this.onChanged, this.obscureText = false, this.keyboardType, this.style, this.margin, this.onSuffixIconPressed, this.initialValue, this.controller, this.cursorColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: TextFormField(
        onChanged: onChanged,
        obscureText: obscureText,
        obscuringCharacter: '•',
        keyboardType: keyboardType,
        initialValue: initialValue,
        controller: controller,
        style: style ?? interMedium,
        cursorColor: cursorColor ?? AppColors.grey,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ?? interMedium ,
          filled: filled,
          fillColor: fillColor ?? AppColors.white,
          prefixIconConstraints: BoxConstraints(minHeight: 25, minWidth: 25),
          prefixIcon: prefixIcon,
          suffixIconConstraints: BoxConstraints(minWidth: 25, minHeight: 25),
          suffixIcon: isSuffixIcon ? IconButton(onPressed: onSuffixIconPressed, icon: Icon(suffixIcon, color: AppColors.grey,)) : null,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}