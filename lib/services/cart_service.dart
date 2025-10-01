import 'package:big_cart/domain/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CartService {
  Future<bool> postCart(CartModel cart);

  Future<List<CartModel>> getCart();

  Future<void> updateCart(CartModel cart);

  Future<void> delete(String id);
}

class WCCartService extends CartService {
  final _id = FirebaseAuth.instance.currentUser?.uid;
  final ref = FirebaseFirestore.instance.collection('users');

  @override
  Future<bool> postCart(CartModel cart) async {
    try {
      await ref.doc(_id).collection('cart').doc(cart.id).set(cart.toJson());
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<CartModel>> getCart() async {
    try {
      final data = await ref.doc(_id).collection('cart').get();
      return data.docs.map((e) => CartModel.fromJson(e.data())).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateCart(CartModel cart) async{
    try{
      await ref.doc(_id).collection('cart').doc(cart.id).update(cart.toJson());
    }catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> delete(String id) async{
    try{
      await ref.doc(_id).collection('cart').doc(id).delete();
    }catch(e){
      throw Exception(e.toString());
    }
  }
}
