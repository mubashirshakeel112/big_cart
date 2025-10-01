import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? bgColor;
  final bool isTrailingIconShow;
  final bool isLeadingIconShow;
  final double statusBarHeight;

  const PrimaryAppBar({
    super.key,
    required this.title,
    this.isTrailingIconShow = false,
    this.isLeadingIconShow = true,
    required this.statusBarHeight, this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 118 - statusBarHeight,
      backgroundColor: bgColor ?? AppColors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleSpacing: 0,
      actionsPadding: EdgeInsets.only(right: 17),
      leading: isLeadingIconShow
          ? IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(Strings.backArrow, color: AppColors.black),
      )
          : Opacity(opacity: 0, child: SvgPicture.asset(Strings.backArrow, color: AppColors.black)),
      title: Text(title, style: interMedium.copyWith(fontSize: 18, color: AppColors.black)),
      actions: [
        isTrailingIconShow
            ? SvgPicture.asset(Strings.filter, color: AppColors.black)
            : Opacity(opacity: 0, child: SvgPicture.asset(Strings.filter, color: AppColors.black)),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(118 - statusBarHeight);
}
