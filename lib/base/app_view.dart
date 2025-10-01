import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/presentation/product_detail/product_detail_view.dart';
import 'package:big_cart/presentation/splash/splash_view.dart';
import 'package:big_cart/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        initialRoute: SplashView.id,
        onGenerateRoute: RouteGenerator.generateRoutes,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.white),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
