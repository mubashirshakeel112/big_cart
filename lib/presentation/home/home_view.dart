import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/presentation/cart/cart_view.dart';
import 'package:big_cart/presentation/dashboard/dashboard_view.dart';
import 'package:big_cart/presentation/favourite/favourite_view.dart';
import 'package:big_cart/presentation/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  static const String id = '/home_view';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> pages = [DashboardView(), ProfileView(), FavouriteView()];
  int index = 0;
  bool selectedIndex = false;
  bool unSelectedIndex = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: AppColors.white2,
        body: IndexedStack(index: index, children: pages),
        floatingActionButton: Container(
          width: 64,
          height: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, CartView.id);
            },
            child: Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: AppColors.primary.withOpacity(0.26),
                  ),
                ],
              ),
              child: SvgPicture.asset(Strings.shoppingBag, width: 21, height: 25, color: AppColors.white),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: Container(
          width: double.infinity,
          // height: 66,
          padding: EdgeInsets.only(left: 18),
          decoration: BoxDecoration(color: AppColors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 53,
            children: [
              IconButton(
                padding: EdgeInsets.all(20),
                onPressed: () {
                  setState(() {
                    index = 0;
                  });
                },
                icon: SvgPicture.asset(Strings.homeIcon, color: index == 0 ? AppColors.black : AppColors.grey),
              ),
              IconButton(
                padding: EdgeInsets.all(20),
                onPressed: () {
                  setState(() {
                    index = 1;
                  });
                },
                icon: SvgPicture.asset(Strings.profile, color: index == 1 ? AppColors.black : AppColors.grey),
              ),
              IconButton(
                padding: EdgeInsets.all(20),
                onPressed: () {
                  setState(() {
                    index = 2;
                  });
                },
                icon: SvgPicture.asset(
                  Strings.heartOutline,
                  width: 22,
                  height: 18,
                  color: index == 2 ? AppColors.black : AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
