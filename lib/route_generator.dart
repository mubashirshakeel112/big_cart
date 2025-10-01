import 'package:big_cart/presentation/about/about_me_view.dart';
import 'package:big_cart/presentation/address/add_address_view.dart';
import 'package:big_cart/presentation/cart/cart_view.dart';
import 'package:big_cart/presentation/checkout/checkout_view.dart';
import 'package:big_cart/presentation/congrats/congrats_view.dart';
import 'package:big_cart/presentation/credit_cards/credit_cards_view.dart';
import 'package:big_cart/presentation/dashboard/dashboard_view.dart';
import 'package:big_cart/presentation/favourite/favourite_view.dart';
import 'package:big_cart/presentation/forgot/forgot_password_view.dart';
import 'package:big_cart/presentation/home/home_view.dart';
import 'package:big_cart/presentation/login/login_view.dart';
import 'package:big_cart/presentation/notification/notification_view.dart';
import 'package:big_cart/presentation/order/my_orders_view.dart';
import 'package:big_cart/presentation/product_detail/product_detail_view.dart';
import 'package:big_cart/presentation/products/products_view.dart';
import 'package:big_cart/presentation/profile/profile_view.dart';
import 'package:big_cart/presentation/signup/signup_view.dart';
import 'package:big_cart/presentation/splash/splash_view.dart';
import 'package:big_cart/presentation/transaction/transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case SplashView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: SplashView());
      case LoginView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: LoginView());
      case SignupView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: SignupView());
      case DashboardView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: DashboardView());
      case ProductsView.id:
        final args = settings.arguments as String;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ProductsView(category: args),
        );
      case CartView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: CartView());
      case CheckoutView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: CheckoutView());
      case CongratsView.id:
        final args = settings.arguments as String;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: CongratsView(orderId: args),
        );
      case ForgotPasswordView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: ForgotPasswordView());
      case FavouriteView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: FavouriteView());
      case HomeView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: HomeView());
      case ProfileView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: ProfileView());
      case ProductDetailView.id:
        final args = settings.arguments as String;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ProductDetailView(productId: args),
        );
      case AboutMeView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: AboutMeView());
      case MyOrdersView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: MyOrdersView());
      case NotificationView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: NotificationView());
      case TransactionView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: TransactionView());
        case CreditCardView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: CreditCardView());
        case AddAddressView.id:
        return PageTransition(type: PageTransitionType.rightToLeft, child: AddAddressView());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(body: Center(child: Text('Error'))),
    );
  }
}
