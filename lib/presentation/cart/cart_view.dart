import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/domain/models/cart_item_model.dart';
import 'package:big_cart/domain/models/checkout_model.dart';
import 'package:big_cart/presentation/cart/notifier/cart_notifier.dart';
import 'package:big_cart/presentation/cart/widgets/cart_loader.dart';
import 'package:big_cart/presentation/checkout/checkout_view.dart';
import 'package:big_cart/presentation/checkout/notifier/checkout_notifier.dart';
import 'package:big_cart/presentation/dashboard/notifier/products_notifier.dart';
import 'package:big_cart/widgets/custom_app_bar.dart';
import 'package:big_cart/widgets/custom_button.dart';
import 'package:big_cart/widgets/custom_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartView extends ConsumerStatefulWidget {
  static const String id = '/cart_view';

  const CartView({super.key});

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(cartProvider.notifier).getCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final productState = ref.watch(productsProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final checkoutNotifier = ref.read(checkoutProvider.notifier);


    final cartItems = cartState.carts.map((cart) {
      final product = productState.products.firstWhere(
        (p) => p.id == cart.id,
        orElse: () => throw Exception("Product not found for id ${cart.id}"),
      );
      return CartItemUIModel(
        id: cart.id,
        title: product.title,
        subtitle: product.subtitle,
        image: product.image,
        price: product.price,
        bgColor: product.bgColor,
        quantity: cart.quantity,
      );
    }).toList();

    final subtotal = cartItems.fold<double>(0, (sum, item) => sum + (item.price * item.quantity));
    const shippingCharges = 5.0;
    final total = subtotal + shippingCharges;

    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: PrimaryAppBar(title: 'Shopping Cart', statusBarHeight: MediaQuery.of(context).viewPadding.top),
      body: cartState.carts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(Strings.shoppingBag, width: 99, height: 115),
                  SizedBox(height: 36),
                  Text('Your cart is empty !', style: interSemiBold.copyWith(fontSize: 20, color: AppColors.black),),
                  SizedBox(height: 12),
                  Text('You will get a response within\na few minutes.', style: interMedium.copyWith(fontSize: 15), textAlign: TextAlign.center),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: cartState.isLoading
                      ? CartLoader()
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 20),
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final cart = cartItems[index];
                            return SecondaryCard(
                              title: cart.title,
                              subtitle: cart.subtitle,
                              price: cart.price,
                              quantity: cart.quantity,
                              productBgColor: Color(int.parse(cart.bgColor.replaceFirst('#', '0xFF'))),
                              image: cart.image,
                              onDelete: () {
                                cartNotifier.delete(cart.id);
                              },
                              increment: () {
                                cartNotifier.incrementQuantity(
                                  productState.products.firstWhere((p) => p.id == cart.id),
                                );
                              },
                              decrement: () {
                                if (cartState.carts[index].quantity > 1) {
                                  cartNotifier.decrementQuantity(
                                    productState.products.firstWhere((p) => p.id == cart.id),
                                  );
                                }
                              },
                            );
                          },
                        ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 17, vertical: 18),
                  decoration: BoxDecoration(color: AppColors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtotal', style: interMedium.copyWith(fontSize: 12)),
                          Text('\$${subtotal.toStringAsFixed(2)}', style: interMedium.copyWith(fontSize: 12)),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Shipping charges', style: interMedium.copyWith(fontSize: 12)),
                          Text('\$$shippingCharges', style: interMedium.copyWith(fontSize: 12)),
                        ],
                      ),
                      SizedBox(height: 12),
                      Divider(height: 0, color: AppColors.grey3),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: interSemiBold.copyWith(fontSize: 18, color: AppColors.black)),
                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: interSemiBold.copyWith(fontSize: 18, color: AppColors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      PrimaryButton(
                        onPressed: () {
                          final  List<Items> items = [];
                          for(var cartItem in cartItems){
                            final item = Items(id: cartItem.id, title: cartItem.title, quantity: cartItem.quantity, price: cartItem.price);
                            items.add(item);
                          }
                          checkoutNotifier.setItems(items);
                          checkoutNotifier.setTotalPrice(total);
                          Navigator.pushNamed(context, CheckoutView.id);
                        },
                        title: 'Checkout',
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
