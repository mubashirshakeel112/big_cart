import 'package:big_cart/domain/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UsersService{
  Future<void> setUser(UsersModel users);
  Future<UsersModel> getUser(String id);
}

class WCUsersService extends UsersService{
  final ref = FirebaseFirestore.instance.collection('users');
  @override
  Future<void> setUser(UsersModel users) async{
    try{
      return await ref.doc(users.id).set(users.toJson());
    }catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Future<UsersModel> getUser(String id) async{
    final userData = await ref.doc(id).get();
    return UsersModel.fromJson(userData.data()!);
  }
}