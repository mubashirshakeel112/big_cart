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

// ✅ Custom widget for point-wise content
// class AboutPoint extends StatelessWidget {
//   final String text;
//   const AboutPoint({super.key, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Icon(Icons.check_circle, color: Colors.green, size: 20),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Text(
//             text,
//             style: const TextStyle(fontSize: 15),
//           ),
//         ),
//       ],
//     );
//   }
// }


// class AboutMeView extends StatelessWidget {
//   static const String id = '/about_me_view';
//   const AboutMeView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("About Us"),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20),
//
//             // Dummy App Logo
//             CircleAvatar(
//               radius: 50,
//               backgroundColor: Colors.green.shade100,
//               child: const Icon(Icons.shopping_cart, size: 50, color: Colors.green),
//             ),
//
//             const SizedBox(height: 20),
//             const Text(
//               "Big Cart",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const Text(
//               "Version 1.0.0",
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//
//             const SizedBox(height: 30),
//             const Text(
//               "Big Cart is your one-stop solution for all grocery needs. "
//                   "We aim to provide fresh products with fast delivery.",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16),
//             ),
//
//             const SizedBox(height: 30),
//             const Divider(),
//
//             // Contact Section
//             ListTile(
//               leading: const Icon(Icons.email, color: Colors.green),
//               title: const Text("support@bigcart.com"),
//             ),
//             ListTile(
//               leading: const Icon(Icons.phone, color: Colors.green),
//               title: const Text("+1 234 567 890"),
//             ),
//             ListTile(
//               leading: const Icon(Icons.language, color: Colors.green),
//               title: const Text("www.bigcart.com"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

