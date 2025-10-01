import 'package:big_cart/domain/models/cart_model.dart';
import 'package:big_cart/services/cart_service.dart';

class CartRepository extends CartService{
  final WCCartService _wcCartService = WCCartService();
  @override
  Future<bool> postCart(CartModel cart) async{
    return await _wcCartService.postCart(cart);
  }

  @override
  Future<List<CartModel>> getCart() async{
    return await _wcCartService.getCart();
  }

  @override
  Future<void> updateCart(CartModel cart) async{
    await _wcCartService.updateCart(cart);
  }

  @override
  Future<void> delete(String id) async{
    await _wcCartService.delete(id);
  }
}