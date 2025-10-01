import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomLoader extends StatelessWidget {
  final String title;
  const CustomLoader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      color: AppColors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              color: AppColors.primary,

            ),
          ),
          SizedBox(width: 15,),
          Text(title, style: interSemiBold.copyWith(fontSize: 15, color: AppColors.white),),
        ],
      ),
    );
  }
}
