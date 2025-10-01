import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:flutter/material.dart';

class AboutPoint extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const AboutPoint({
    super.key,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Dot as bullet
           Text(
            "• ",
            style: interBold.copyWith(fontSize: 18, color: AppColors.grey),
          ),
          Expanded(
            child: Text(
              text,
              style: textStyle ?? interMedium,
            ),
          ),
        ],
      ),
    );
  }
}
