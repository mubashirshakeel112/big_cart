import 'package:big_cart/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartLoader extends StatelessWidget {
  const CartLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      // enabled: true,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.only(left: 20, top: 10),
            dense: true,
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: AppColors.white,
                  width: 100,
                  height: 12,
                ),
                SizedBox(height: 8,),
                Container(
                  color: AppColors.white,
                  width: 150,
                  height: 12,
                ),
                SizedBox(height: 8,),
                Container(
                  color: AppColors.white,
                  width: 80,
                  height: 12,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
