import 'package:big_cart/domain/models/favourite_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FavouriteService {
  Future<bool> postFavourite(FavouriteModel favourite);

  Future<List<FavouriteModel>> getFavourite();
  Future<void> deleteFavourite(String id);
}

class WCFavouriteService extends FavouriteService {
  @override
  Future<bool> postFavourite(FavouriteModel favourite) async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favourites')
          .doc(favourite.id)
          .set(favourite.toJson());
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<FavouriteModel>> getFavourite() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final ref = await FirebaseFirestore.instance.collection('users').doc(userId).collection('favourites').get();
    try {
      return ref.docs.map((e) => FavouriteModel.fromJson(e.data())).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteFavourite(String id) async{
    try{
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      await FirebaseFirestore.instance.collection('users').doc(userId).collection('favourites').doc(id).delete();
    }catch(e){
      throw Exception(e.toString());
    }
  }
}
