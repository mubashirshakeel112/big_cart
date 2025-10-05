import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/presentation/cart/notifier/cart_notifier.dart';
import 'package:big_cart/presentation/dashboard/notifier/products_notifier.dart';
import 'package:big_cart/presentation/home/home_view.dart';
import 'package:big_cart/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class CongratsView extends ConsumerStatefulWidget {
  static const String id = '/congrats_view';
  final String orderId;

  const CongratsView({super.key, required this.orderId});

  @override
  ConsumerState<CongratsView> createState() => _CongratsViewState();
}

class _CongratsViewState extends ConsumerState<CongratsView> {
  bool isSuccess = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        isSuccess = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 700),
          transitionBuilder: (child, animation) {
            final inAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
            final outAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);

            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: child.key == const ValueKey('content')
                    ? Tween<double>(begin: 0.8, end: 1.0).animate(inAnimation)
                    : Tween<double>(begin: 1.0, end: 0.8).animate(outAnimation),
                child: child,
              ),
            );
          },
          child: !isSuccess
              ? Lottie.asset(Strings.success, repeat: false, key: const ValueKey('lottie'))
              : Column(
                  key: const ValueKey('content'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Strings.congrats),
                    const SizedBox(height: 45),
                    Text('Congrats!', style: interSemiBold.copyWith(fontSize: 24, color: AppColors.black)),
                    const SizedBox(height: 8),
                    Text(
                      'Your Order #${widget.orderId} is Successfully Received',
                      style: interRegular.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
                      child: PrimaryButton(
                        onPressed: () {
                          ref.read(productsProvider.notifier).getProducts();
                          ref.read(cartProvider.notifier).getCart();
                          Navigator.of(context).pushNamedAndRemoveUntil(HomeView.id, (Route<dynamic> route) => false);
                        },
                        title: 'Go to Home',
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
