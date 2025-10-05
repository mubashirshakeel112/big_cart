import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/presentation/about/widgets/about_point.dart';
import 'package:big_cart/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AboutMeView extends StatelessWidget {
  static const String id = '/about_me_view';
  const AboutMeView({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBasHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: PrimaryAppBar(
        title: "About Us",
        statusBarHeight: statusBasHeight,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(Strings.bigCart, height: 50,),
            //  Text(
            //   "Big Cart",
            //   style: interBold.copyWith(fontSize: 25, color: AppColors.black),
            // ),
             Text(
              "Version 1.0.0",
              style: interMedium.copyWith(fontSize: 12),
            ),

            const SizedBox(height: 30),

            // About Description
             Text(
              "Big Cart is a modern e-commerce platform designed "
                  "to make shopping fast, simple, and convenient.",
              textAlign: TextAlign.center,
              style: interRegular.copyWith(fontSize: 15),
            ),

            const SizedBox(height: 30),

            // Why Choose Us
             Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Why Choose Us?",
                style: interBold.copyWith(fontSize: 15, color: AppColors.black)
              ),
            ),
            const SizedBox(height: 12),

            Column(
              children: const [
                AboutPoint(text: "Fresh and high-quality groceries"),
                AboutPoint(text: "Fast and reliable delivery"),
                AboutPoint(text: "Secure online payments"),
                AboutPoint(text: "Easy-to-use shopping experience"),
                AboutPoint(text: "24/7 customer support"),
              ],
            ),

            const SizedBox(height: 30),

            // Mission
             Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Our Mission",
                style: interBold.copyWith(fontSize: 15, color: AppColors.black)
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "“To make everyday shopping simple, affordable, "
                  "and accessible for everyone.”",
              textAlign: TextAlign.center,
              style: interRegular.copyWith(fontSize: 15),
            ),

            const SizedBox(height: 30),
            const Divider(),

            // Contact Section
             Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Contact Us",
                style: interBold.copyWith(fontSize: 15, color: AppColors.black)
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading:  Icon(Icons.email_outlined, color: AppColors.red),
              title:  Text("support@bigcart.com", style: interRegular.copyWith(fontSize: 15),),
            ),
            ListTile(
              leading:  Icon(Icons.phone, color: AppColors.green),
              title:  Text("+1 234 567 890", style: interRegular.copyWith(fontSize: 15),),
            ),
            ListTile(
              leading:  Icon(Icons.language, color: AppColors.blue),
              title:  Text("www.bigcart.com", style: interRegular.copyWith(fontSize: 15),),
            ),
          ],
        ),
      ),
    );
  }
}

