
import 'package:big_cart/domain/models/cart_model.dart';
import 'package:big_cart/domain/models/products_model.dart';

extension ProductMapper on ProductsModel {
  CartModel toCartModel({required int quantity}) {
    return CartModel(
      id: id,
      quantity: quantity,
      createdAt: DateTime.now(),
    );
  }

}
