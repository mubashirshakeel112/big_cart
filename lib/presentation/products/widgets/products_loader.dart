import 'package:big_cart/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductsLoader extends StatelessWidget {
  const ProductsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      // enabled: true,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 25),
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: AppColors.white,
                width: double.infinity,
                height: 200,
              ),
              SizedBox(height: 5,),
              Container(
                color: AppColors.white,
                width: double.infinity,
                height: 34,
              ),
            ],
          );
        }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 20,
        childAspectRatio: 0.75,
      ),
      ),
    );
  }
}
