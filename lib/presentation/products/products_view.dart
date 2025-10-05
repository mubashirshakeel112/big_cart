import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/domain/models/cart_model.dart';
import 'package:big_cart/presentation/cart/notifier/cart_notifier.dart';
import 'package:big_cart/presentation/favourite/notifier/favourite_notifier.dart';
import 'package:big_cart/presentation/product_detail/product_detail_view.dart';
import 'package:big_cart/presentation/products/notifier/products_category_notifier.dart';
import 'package:big_cart/presentation/products/widgets/products_loader.dart';
import 'package:big_cart/widgets/custom_app_bar.dart';
import 'package:big_cart/widgets/custom_cards.dart';
import 'package:big_cart/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsView extends ConsumerStatefulWidget {
  static const String id = '/products_view';
  final String category;

  const ProductsView({super.key, required this.category});

  @override
  ConsumerState<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState<ProductsView> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(favouriteProvider.notifier).getFavourites();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsCategoryProvider(widget.category));
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final favouriteNotifier = ref.read(favouriteProvider.notifier);
    final favouriteState = ref.watch(favouriteProvider);

    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: PrimaryAppBar(
        title: widget.category,
        isTrailingIconShow: true,
        statusBarHeight: MediaQuery.of(context).viewPadding.top,
      ),
      body: state.when(
        data: (value) {
          return Column(
            children: [
              Expanded(
                child: value.isEmpty
                    ? Center(
                        child: Text(
                          'No item available',
                          style: interMedium.copyWith(fontSize: 15, color: AppColors.black),
                        ),
                      )
                    : GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 25),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 20,
                          childAspectRatio: 181 / 234,
                        ),
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          final product = value[index];
                          final cartItem = cartState.carts.firstWhere(
                            (item) => item.id == product.id,
                            orElse: () => CartModel(id: product.id, quantity: 1, createdAt: DateTime.now()),
                          );
                          return PrimaryCard(
                            title: value[index].title,
                            price: value[index].price,
                            subtitle: value[index].subtitle,
                            image: value[index].image,
                            productBgColor: Color(int.parse(value[index].bgColor.replaceFirst('#', '0xFF'))),
                            favouriteIcon: favouriteState.favourites.any((fav) => fav.id == product.id)
                                ? Strings.heartFill
                                : Strings.heartOutline,
                            quantity: cartItem.quantity,
                            isCartAdded: cartState.carts.any((cart) => cart.id == product.id),
                            // isLoading: ,
                            onTap: () {
                              Navigator.pushNamed(context, ProductDetailView.id, arguments: value[index].id);
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
                            onFavouriteTap: () async {
                              await favouriteNotifier.postFavourite(product.id);
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => ProductsLoader(),
      ),
    );
  }
}
