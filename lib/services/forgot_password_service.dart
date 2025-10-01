import 'package:big_cart/widgets/firebase_error_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ForgotPasswordService{
  Future<bool> forgotPassword(String email);
}

class WCForgotPasswordService extends ForgotPasswordService{
  final ref = FirebaseAuth.instance;
  @override
  Future<bool> forgotPassword(String email) async{
    try{
      await ref.sendPasswordResetEmail(email: email);
      return true;
    }catch(e){
      throw Exception(FirebaseErrorHandler.handleFirebaseError(e));
    }
  }

}