import 'package:big_cart/domain/models/checkout_model.dart';
import 'package:big_cart/services/checkout_service.dart';

class CheckoutRepository extends CheckoutService{
  final WCCheckoutService _wcCheckoutService = WCCheckoutService();
  @override
  Future<void> postCheckout(OrderModel order) async{
    await _wcCheckoutService.postCheckout(order);
  }
}