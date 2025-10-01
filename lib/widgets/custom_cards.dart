import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryCard extends StatelessWidget {
  final String title;
  final double price;
  final String subtitle;
  final Color productBgColor;
  final String image;
  final int? quantity;
  final VoidCallback? onTap;
  final VoidCallback? onFavouriteTap;
  final String favouriteIcon;
  final VoidCallback addToCart;
  final VoidCallback? increment;
  final VoidCallback? decrement;
  final bool isCartAdded;
  final bool isLoading;

  const PrimaryCard({
    super.key,
    required this.title,
    required this.price,
    required this.subtitle,
    required this.productBgColor,
    required this.image,
    this.onTap,
    this.onFavouriteTap,
    required this.favouriteIcon,
    required this.addToCart,
    this.isCartAdded = false, this.quantity, this.increment, this.decrement, this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColors.white,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 21),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(color: productBgColor, shape: BoxShape.circle),
                      ),
                      Positioned(
                        top: 21,
                        left: 0,
                        right: 0,
                        // bottom: -15,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.network(image, fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // SizedBox(height: 8,),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: interMedium.copyWith(fontSize: 12, color: AppColors.primary),
                  ),
                  SizedBox(height: 0),
                  Text(
                    title,
                    style: interSemiBold.copyWith(color: AppColors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(subtitle, style: interMedium.copyWith(fontSize: 12)),
                  SizedBox(height: 11),
                  Divider(color: AppColors.grey3, height: 0),
                  // SizedBox(height: 12),
                  isCartAdded ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: increment, icon: Icon(Icons.add, color: AppColors.primary,)),
                      Text(quantity.toString(), style: interMedium.copyWith(fontSize: 18, color: AppColors.black),),
                      IconButton(onPressed: decrement, icon: Icon(Icons.remove, color: AppColors.primary,))
                    ],
                  ) : isLoading ? Center(child: CircularProgressIndicator(color: AppColors.primary,),) :
                      Material(
                        color: AppColors.white,
                        child: InkWell(
                          onTap: (){
                            addToCart();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Strings.shoppingBag),
                                SizedBox(width: 10),
                                Text('Add to cart', style: interMedium.copyWith(fontSize: 12, color: AppColors.black)),
                              ],
                            ),
                          ),
                        ),
                      ),
                  // SecondaryButton(onPressed: (){
                  //   addToCart();
                  // }, title: 'Add to cart',),
                  // SizedBox(height: 11),
                ],
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: AppColors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: onFavouriteTap,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(favouriteIcon, width: 16, height: 16),
                      ),
                    ),
                  ),
                ),
            ),
            // Positioned(
            //   top: 21,
            //   left: 0,
            //   right: 0,
            //   child: Column(
            //     children: [
            //       Stack(
            //         children: [
            //           Container(
            //             width: 84,
            //             height: 84,
            //             decoration: BoxDecoration(color: productBgColor, shape: BoxShape.circle),
            //           ),
            //           Positioned(
            //             top: 21,
            //             left: 0,
            //             right: 0,
            //             // bottom: 0,
            //             child: Image.network(image, fit: BoxFit.contain,),
            //           )
            //         ],
            //       ),
            //       SizedBox(height: 8,),
            //       Text('\$${price.toStringAsFixed(2)}', style: interMedium.copyWith(fontSize: 12, color: AppColors.primary),),
            //       SizedBox(height: 4,),
            //       Text(title, style: interSemiBold.copyWith(color: AppColors.black),),
            //       Text(subtitle, style: interMedium.copyWith(fontSize: 12),),
            //       SizedBox(height: 11,),
            //       Divider(color: AppColors.grey3,),
            //       SizedBox(height: 5,),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           SvgPicture.asset(Strings.shoppingBag),
            //           SizedBox(width: 10,),
            //           Text('Add to cart', style: interMedium.copyWith(fontSize: 12, color: AppColors.black),)
            //         ],
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class SecondaryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color productBgColor;
  final String image;
  final double price;
  final int quantity;
  final bool isTrailing;
  final VoidCallback? onDelete;
  final VoidCallback? increment;
  final VoidCallback? decrement;
  final VoidCallback? onTap;

  const SecondaryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantity,
    this.increment,
    this.decrement,
    required this.productBgColor,
    required this.image, this.onDelete, this.onTap, this.isTrailing = true
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 90 / MediaQuery.of(context).size.width,
          motion: ScrollMotion(),
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  height: 100,
                  margin: EdgeInsets.only(left: 6),
                  alignment: Alignment.center,
                  color: AppColors.red,
                  child: SvgPicture.asset(Strings.delete),
                ),
              ),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 100,
            color: AppColors.white,
            padding: EdgeInsets.only(left: 17, right: 10),
            // margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(color: productBgColor, shape: BoxShape.circle),
                  child: Image.network(image),
                ),
                SizedBox(width: 22),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\$${price.toStringAsFixed(2)} x $quantity', style: interMedium.copyWith(fontSize: 12, color: AppColors.primary)),
                      Text(title, style: interSemiBold.copyWith(fontSize: 15, color: AppColors.black)),
                      Text(subtitle, style: interRegular.copyWith(fontSize: 12)),
                    ],
                  ),
                ),
                if(isTrailing == true)
                Column(
                  // spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      constraints: BoxConstraints(maxWidth: 25, maxHeight: 25),
                      padding: EdgeInsets.only(top: 2),
                      onPressed: increment,
                      icon: Icon(Icons.add, color: AppColors.primary),
                    ),
                    Text(quantity.toString(), style: interMedium.copyWith(fontSize: 15)),
                    IconButton(
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      constraints: BoxConstraints(maxWidth: 25, maxHeight: 25),
                      padding: EdgeInsets.only(bottom: 2),
                      onPressed: decrement,
                      icon: Icon(Icons.remove, color: AppColors.primary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
