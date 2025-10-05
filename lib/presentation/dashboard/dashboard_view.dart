import 'dart:async';

import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/domain/models/cart_model.dart';
import 'package:big_cart/presentation/cart/notifier/cart_notifier.dart';
import 'package:big_cart/presentation/dashboard/notifier/products_notifier.dart';
import 'package:big_cart/presentation/dashboard/widgets/dashboard_categories_sec.dart';
import 'package:big_cart/presentation/dashboard/widgets/dashboard_loader.dart';
import 'package:big_cart/presentation/favourite/notifier/favourite_notifier.dart';
import 'package:big_cart/presentation/product_detail/product_detail_view.dart';
import 'package:big_cart/presentation/products/products_view.dart';
import 'package:big_cart/widgets/custom_cards.dart';
import 'package:big_cart/widgets/custom_snack_bar.dart';
import 'package:big_cart/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class DashboardView extends ConsumerStatefulWidget {
  static const String id = '/dashboard_view';

  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    Future.microtask(() {
      final notifier = ref.read(productsProvider.notifier);
      notifier.getProducts();
      ref.read(cartProvider.notifier).getCart();
      ref.read(favouriteProvider.notifier).getFavourites();
    });
    super.initState();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(productsProvider.notifier).filterProducts(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productsProvider);
    final favouriteNotifier = ref.read(favouriteProvider.notifier);
    final favouriteState = ref.watch(favouriteProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.white, AppColors.white, AppColors.white2],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 51),
            CustomTextField(
              hintText: 'Search keywords..',
              controller: _searchController,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 21, right: 10),
                child: SvgPicture.asset(Strings.search),
              ),
              isSuffixIcon: true,
              suffixIcon: Icons.density_medium_sharp,
              fillColor: AppColors.grey2,
              margin: EdgeInsets.symmetric(horizontal: 17),
              onChanged: _onSearchChanged,
            ),
            Expanded(
              child: productState.isLoading
                  ? DashboardLoader()
                  : productState.filteredProducts.isEmpty
                  ? Center(
                      child: Lottie.asset(Strings.searchNotFound)
                    )
                  : ListView(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.344,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 17,
                                right: 17,
                                child: Image.asset(Strings.home, fit: BoxFit.contain),
                              ),
                              Positioned(
                                top: 151,
                                left: 61,
                                right: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '20% off on your\nfirst purchase',
                                      style: interSemiBold.copyWith(fontSize: 18, color: AppColors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Categories', style: interSemiBold.copyWith(fontSize: 18, color: AppColors.black)),
                            ],
                          ),
                        ),
                        SizedBox(height: 17),
                        SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 19,
                            children: [
                              DashboardCategoriesSec(
                                title: 'Vegetables',
                                image: Strings.vegetables,
                                bgColor: AppColors.green2,
                                onTap: () {
                                  Navigator.pushNamed(context, ProductsView.id, arguments: 'Vegetables');
                                },
                              ),
                              DashboardCategoriesSec(
                                title: 'Fruits',
                                image: Strings.fruits,
                                bgColor: AppColors.orange2,
                                onTap: () {
                                  Navigator.pushNamed(context, ProductsView.id, arguments: 'Fruits');
                                },
                              ),
                              DashboardCategoriesSec(
                                title: 'Beverages',
                                image: Strings.beverages,
                                bgColor: AppColors.yellow2,
                                onTap: () {
                                  Navigator.pushNamed(context, ProductsView.id, arguments: 'Beverages');
                                },
                              ),
                              DashboardCategoriesSec(
                                title: 'Grocery',
                                image: Strings.grocery,
                                bgColor: AppColors.purple2,
                                onTap: () {
                                  Navigator.pushNamed(context, ProductsView.id, arguments: 'Grocery');
                                },
                              ),
                              DashboardCategoriesSec(
                                title: 'Edible Oil',
                                image: Strings.edibleOil,
                                bgColor: AppColors.sky2,
                                onTap: () {
                                  Navigator.pushNamed(context, ProductsView.id, arguments: 'Edible Oil');
                                },
                              ),
                              DashboardCategoriesSec(
                                title: 'House Hold',
                                image: Strings.houseHold,
                                bgColor: AppColors.pink2,
                                onTap: () {
                                  Navigator.pushNamed(context, ProductsView.id, arguments: 'House Hold');
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Featured products',
                                style: interSemiBold.copyWith(fontSize: 18, color: AppColors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 21),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 18,
                            childAspectRatio: 181 / 234,
                          ),
                          itemCount: productState.filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = productState.filteredProducts[index];

                            final cartItem = cartState.carts.firstWhere(
                              (item) => item.id == product.id,
                              orElse: () => CartModel(id: product.id, quantity: 1, createdAt: DateTime.now()),
                            );
                            return PrimaryCard(
                              title: product.title,
                              price: product.price,
                              subtitle: product.subtitle,
                              productBgColor: Color(
                                int.parse(productState.products[index].bgColor.replaceFirst('#', '0xff')),
                              ),
                              image: product.image,
                              quantity: cartItem.quantity,
                              favouriteIcon: favouriteState.favourites.any((fav) => fav.id == product.id)
                                  ? Strings.heartFill
                                  : Strings.heartOutline,
                              isCartAdded: cartState.carts.any((item) => item.id == product.id),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ProductDetailView.id,
                                  arguments: product.id,
                                );
                              },
                              onFavouriteTap: () async {
                                await favouriteNotifier.postFavourite(product.id);
                              },
                              addToCart: () async {
                                bool res = await cartNotifier.postCart(product.id, cartItem.quantity);
                                if (res) {
                                  CustomSnackBar.successSnackBar(
                                    context: context,
                                    title: 'Success',
                                    message: 'Add to cart Successfully',
                                  );
                                }
                              },
                              increment: () async {
                                await cartNotifier.incrementQuantity(product);
                              },
                              decrement: () async {
                                await cartNotifier.decrementQuantity(product);
                              },
                            );
                          },
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
