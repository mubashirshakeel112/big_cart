import 'package:big_cart/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardCategoriesSec extends StatelessWidget {
  final String title;
  final String image;
  final Color bgColor;
  final VoidCallback? onTap;
  const DashboardCategoriesSec({super.key, required this.title, required this.image, required this.bgColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle
            ),
            child: SvgPicture.asset(image),
          ),
          SizedBox(height: 11,),
          Text(title, style: interMedium.copyWith(fontSize: 10),)
        ],
      ),
    );
  }
}
