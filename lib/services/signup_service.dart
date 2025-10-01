import 'package:big_cart/widgets/firebase_error_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignupService{
  Future<bool> signup(String email, String password);
}

class WCSignupService extends SignupService{
  final ref = FirebaseAuth.instance;
  @override
  Future<bool> signup(String email, String password) async{
   try{
     await ref.createUserWithEmailAndPassword(email: email, password: password);
     return true;
   }catch(e){
     throw Exception(FirebaseErrorHandler.handleFirebaseError(e));
   }
  }
}