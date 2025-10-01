import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomStack extends StatelessWidget {
  final String bgImage;
  final Widget child;
  final double? height;
  const CustomStack({super.key, required this.bgImage, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).viewPadding.top;
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(bgImage, width: double.infinity, height: height ?? size.height * 0.576, fit: BoxFit.fill,),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.black,
                  AppColors.black.withAlpha(50),
                  AppColors.black.withAlpha(75),
                  Colors.transparent,
                ]
              )
            //   boxShadow: [
            //     BoxShadow(
            //       offset: Offset(0, -24),
            //       color: AppColors.black
            //     ),
            //     BoxShadow(
            //       offset: Offset(0, 30),
            //       color: AppColors.black.withAlpha(24)
            //     ),
            //     BoxShadow(
            //       offset: Offset(0, 60),
            //       color: AppColors.black.withAlpha(46)
            //     ),
            //     BoxShadow(
            //       offset: Offset(0, 80),
            //       color: AppColors.black.withAlpha(60)
            //     )
            //   ]
            ),
            child: AppBar(
              toolbarHeight: 131 - statusBar,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              scrolledUnderElevation: 0,
              elevation: 0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(left: 17, top: 63),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(Strings.backArrow)),
                    Text('Welcome', style: interMedium.copyWith(color: AppColors.white),),
                    Opacity(
                        opacity: 0,
                        child: Icon(Icons.arrow_back))
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.50,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              height: size.height * 0.50,
              padding: EdgeInsets.symmetric(horizontal: 17),
              decoration: BoxDecoration(
                color: AppColors.white2,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),
              child: child,
            )),
      ],
    );
  }
}
