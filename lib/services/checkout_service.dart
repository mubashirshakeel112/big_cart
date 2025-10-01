import 'package:big_cart/domain/models/checkout_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CheckoutService{
  Future<void> postCheckout(OrderModel order);
}

class WCCheckoutService extends CheckoutService{
  final ref = FirebaseFirestore.instance.collection('users');
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  @override
  Future<void> postCheckout(OrderModel order) async{
    await ref.doc(userId).collection('orders').doc(order.id).set(order.toMap());
  }
}