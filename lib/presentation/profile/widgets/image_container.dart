import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const ImageContainer({
    super.key,
    required this.icon,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white2,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.black),
              const SizedBox(height: 4),
              Text(
                title,
                style: interMedium.copyWith(color: AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
