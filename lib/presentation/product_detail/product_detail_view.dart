import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/presentation/cart/cart_view.dart';
import 'package:big_cart/presentation/cart/notifier/cart_notifier.dart';
import 'package:big_cart/presentation/favourite/notifier/favourite_notifier.dart';
import 'package:big_cart/presentation/product_detail/notifier/product_detailed_notifier.dart';
import 'package:big_cart/widgets/custom_button.dart';
import 'package:big_cart/widgets/custom_loader.dart';
import 'package:big_cart/widgets/custom_snack_bar.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

final localQuantityProvider = StateProvider.family<int, String>((ref, id) => 1);

class ProductDetailView extends ConsumerStatefulWidget {
  static const String id = '/products_detail_view';

  final String productId;

  const ProductDetailView({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends ConsumerState<ProductDetailView> {
  double _rating = 3.5;

  @override
  void initState() {
    Future.microtask(() {
      ref.read(localQuantityProvider(widget.productId).notifier).state = 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productDetailedProvider(widget.productId));
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final quantityState = ref.watch(localQuantityProvider(widget.productId));
    final favouriteNotifier = ref.read(favouriteProvider.notifier);
    final favouriteState = ref.watch(favouriteProvider);

    return Scaffold(
      body: state.when(
        data: (product) {
          return Stack(
            children: [
              Positioned(
                top: -120,
                left: -41,
                right: -41,
                child: Container(
                  width: double.infinity,
                  height: 490,
                  padding: EdgeInsetsGeometry.only(top: 178, left: 48),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Color(int.parse(product.bgColor.replaceFirst('#', '0xFF'))),
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100), bottomRight: Radius.circular(100))
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(Strings.backArrow, color: AppColors.black),
                  ),
                ),
              ),
              Positioned(
                top: 101,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 324,
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
                  alignment: Alignment.center,
                  child: Image.network(product.image, height: 324, fit: BoxFit.contain),
                ),
              ),

              DraggableScrollableSheet(
                initialChildSize: 0.45,
                minChildSize: 0.45,
                maxChildSize: 1,
                builder: (context, controller) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 17),
                    decoration: BoxDecoration(
                      color: AppColors.white2,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 26),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${(product.price * quantityState).toStringAsFixed(2)}',
                                style: interSemiBold.copyWith(fontSize: 18, color: AppColors.green),
                              ),
                              InkWell(
                                onTap: () {
                                  favouriteNotifier.postFavourite(product.id);
                                },
                                child: SvgPicture.asset(
                                  favouriteState.favourites.any((fav) => fav.id == product.id)
                                      ? Strings.heartFill
                                      : Strings.heartOutline,
                                ),
                              ),
                            ],
                          ),
                          Text(product.title, style: interSemiBold.copyWith(fontSize: 20, color: AppColors.black)),
                          Text(product.subtitle, style: interMedium.copyWith(fontSize: 12)),
                          SizedBox(height: 9),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 2,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 18,
                                child: Text(
                                  _rating.toString(),
                                  style: interMedium.copyWith(fontSize: 12, color: AppColors.black),
                                ),
                              ),
                              RatingBar(
                                initialRating: 3.5,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20,
                                minRating: 1,
                                ratingWidget: RatingWidget(
                                  full: SvgPicture.asset(Strings.starFill, color: AppColors.yellow),
                                  half: SvgPicture.asset(Strings.starHalf, color: AppColors.yellow),
                                  empty: SvgPicture.asset(Strings.starOutline, color: AppColors.yellow),
                                ),
                                itemPadding: EdgeInsets.symmetric(horizontal: 3),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    _rating = rating;
                                  });
                                  print(rating);
                                },
                              ),
                              Text('(89 reviews)', style: interMedium.copyWith(fontSize: 12)),
                            ],
                          ),
                          SizedBox(height: 16),
                          ExpandableText(
                            product.description,
                            style: interRegular.copyWith(fontSize: 12),
                            expandText: 'See more',
                            collapseText: 'See less',
                            linkColor: AppColors.black,
                            maxLines: 5,
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 50,
                            padding: EdgeInsets.only(left: 17, right: 0),
                            decoration: BoxDecoration(color: AppColors.white),
                            child: Row(
                              children: [
                                Expanded(child: Text('Quantity', style: interMedium.copyWith(fontSize: 12))),
                                IconButton(
                                  onPressed: () {
                                    if (quantityState > 1) {
                                      ref.read(localQuantityProvider(product.id).notifier).state--;
                                    }
                                  },
                                  icon: Icon(Icons.remove, color: AppColors.primary),
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.symmetric(vertical: BorderSide(width: 1, color: AppColors.grey3)),
                                  ),
                                  child: Text(
                                    quantityState.toString(),
                                    style: interMedium.copyWith(fontSize: 18, color: AppColors.black),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    ref.read(localQuantityProvider(product.id).notifier).state++;
                                  },
                                  icon: Icon(Icons.add, color: AppColors.primary),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 13),

                          /// Add to cart button
                          cartState.isLoading
                              ? CustomLoader(title: 'Adding...')
                              : PrimaryButton(
                                  onPressed: () async {
                                    bool isCartAdded = await cartNotifier.postCart(
                                      product.id,
                                      ref.watch(localQuantityProvider(product.id)),
                                    );
                                    if (isCartAdded) {
                                      Navigator.pushReplacementNamed(context, CartView.id);
                                      CustomSnackBar.successSnackBar(
                                        context: context,
                                        title: 'Success',
                                        message: 'Added Item Successfully',
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Opacity(
                                        opacity: 0,
                                        child: SvgPicture.asset(
                                          Strings.shoppingBag,
                                          color: AppColors.white,
                                          width: 17,
                                          height: 21,
                                        ),
                                      ),
                                      Text(
                                        'Add to cart',
                                        style: interMedium.copyWith(fontSize: 15, color: AppColors.white),
                                      ),
                                      SvgPicture.asset(
                                        Strings.shoppingBag,
                                        color: AppColors.white,
                                        width: 17,
                                        height: 21,
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => Center(child: Lottie.asset(Strings.shoppingCart, width: 300, height: 300, fit: BoxFit.cover)),
      ),
    );
  }
}
