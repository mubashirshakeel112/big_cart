import 'package:big_cart/domain/models/users_model.dart';
import 'package:big_cart/repository/signout_repository.dart';
import 'package:big_cart/repository/users_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileProvider = FutureProvider<UsersModel>((ref) async{
   final UsersRepository userRepository = UsersRepository();
   final id = FirebaseAuth.instance.currentUser?.uid ?? '';
   UsersModel? users;
   users = await userRepository.getUser(id);
  return users;
});

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref){
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserState>{
  UserNotifier() : super(UserState.initialize());

  final SignOutRepository _signOutRepository = SignOutRepository();

  Future<bool> signOut() async{
   try{
     return await _signOutRepository.signOut();
   }catch(e){
     throw Exception(e.toString());
   }
  }
}

class UserState{
  bool isLoading;

  UserState({required this.isLoading});

  UserState copyWith({bool? isLoading}){
    return UserState(isLoading: isLoading ?? this.isLoading);
  }

  factory UserState.initialize(){
    return UserState(isLoading: false);
  }
}