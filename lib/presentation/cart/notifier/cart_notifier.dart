import 'package:big_cart/domain/models/cart_item_model.dart';
import 'package:big_cart/domain/models/cart_model.dart';
import 'package:big_cart/domain/models/products_model.dart';
import 'package:big_cart/repository/cart_repository.dart';
import 'package:big_cart/utilities/product_mapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState.initialize());

  final CartRepository _cartRepository = CartRepository();

  setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<void> clear() async {
    try {
      for (final cart in state.carts) {
        await _cartRepository.delete(cart.id);
      }
      state = state.copyWith(carts: []);
    } catch (e) {
      throw Exception("Failed to clear cart: $e");
    }
  }

  Future<bool> postCart(String id, int quantity) async {
    setLoading(true);
    try {
      final safeQuantity = quantity > 0 ? quantity : 1;
      final cart = CartModel(
        id: id,
        quantity: safeQuantity,
        createdAt: DateTime.now(),
      );
      await _cartRepository.postCart(cart);
      await getCart(); // refresh state
      return true;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Future<bool> postCart(String id, int quantity) async {
  //   setLoading(true);
  //   try {
  //     final cart = CartModel(id: id, quantity: quantity, createdAt: DateTime.now());
  //     await _cartRepository.postCart(cart);
  //     getCart();
  //     return true;
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   } finally {
  //     setLoading(false);
  //   }
  // }

  Future<void> getCart() async {
    try {
      setLoading(true);
      final carts = await _cartRepository.getCart();
      state = state.copyWith(carts: carts);
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateCart(String id, int quantity) async {
   try{
     final cart = CartModel(id: id,quantity: quantity, createdAt: DateTime.now());
     await _cartRepository.updateCart(cart);
   }catch(e){
     throw Exception(e.toString());
   }
  }

  Future<void> delete(String id) async{
    try{
      await _cartRepository.delete(id);
      getCart();
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<void> incrementQuantity(ProductsModel product) async {
    final carts = [...state.carts];
    final index = carts.indexWhere((c) => c.id == product.id);
    if (index != -1) {
      carts[index] = carts[index].copyWith(quantity: carts[index].quantity + 1);
      state = state.copyWith(carts: carts);
    }
    try {
      await _cartRepository.updateCart(
        product.toCartModel(quantity: carts[index].quantity),
      );
    } catch (e) {
      // rollback if needed
    }
  }

  Future<void> decrementQuantity(ProductsModel product) async {
    final carts = [...state.carts];
    final index = carts.indexWhere((c) => c.id == product.id);
    if (index != -1) {
      final currentQty = carts[index].quantity;
      if (currentQty > 1) {
        carts[index] = carts[index].copyWith(quantity: currentQty - 1);
        state = state.copyWith(carts: carts);
        try {
          await _cartRepository.updateCart(
            product.toCartModel(quantity: carts[index].quantity),
          );
        } catch (e) {}
      } else {
        carts.removeAt(index);
        state = state.copyWith(carts: carts);
      }
    }
  }


  // Future<void> decrementQuantity(ProductsModel product) async {
  //   final carts = [...state.carts];
  //   final index = carts.indexWhere((c) => c.id == product.id);
  //   if (index != -1 && carts[index].quantity > 1) {
  //     carts[index] = carts[index].copyWith(quantity: carts[index].quantity - 1);
  //     state = state.copyWith(carts: carts);
  //
  //     try {
  //       await _cartRepository.updateCart(
  //         product.toCartModel(quantity: carts[index].quantity),
  //       );
  //     } catch (e) {}
  //   }
  // }

}

class CartState {
  bool isLoading;
  List<CartModel> carts;

  CartState({required this.isLoading, required this.carts});

  CartState copyWith({bool? isLoading, List<CartModel>? carts}) {
    return CartState(isLoading: isLoading ?? this.isLoading, carts: carts ?? this.carts);
  }

  factory CartState.initialize() {
    return CartState(isLoading: false, carts: []);
  }
}
