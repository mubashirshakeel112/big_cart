import 'package:big_cart/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DashboardLoader extends StatelessWidget {
  const DashboardLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      // enabled: true,
      child: ListView(
        padding: EdgeInsets.only(top: 10, bottom: 20),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: AppColors.white,
            width: double.infinity,
            height: 283,
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: AppColors.white,
              width: 101,
              height: 12,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 78,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 19),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                      ),
                      SizedBox(height: 10),
                      Container(width: 58, height: 12, color: AppColors.white),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              color: AppColors.white,
              width: 170,
              height: 12,
            ),
          ),
          SizedBox(height: 21),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 17),
            itemCount: 8,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(color: AppColors.white, width: double.infinity, height: 200),
                  SizedBox(height: 5),
                  Container(color: AppColors.white, width: double.infinity, height: 34),
                ],
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 20,
              childAspectRatio: 0.75,
            ),
          ),
        ],
      ),
    );
  }
}
