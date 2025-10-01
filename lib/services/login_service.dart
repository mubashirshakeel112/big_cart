import 'package:big_cart/widgets/firebase_error_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginService{
  Future<bool> login(String email, String password);
}

class WCLoginService extends LoginService{
  final ref = FirebaseAuth.instance;
  @override
  Future<bool> login(String email, String password) async{
    try{
      await ref.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }catch(e){
      throw Exception(FirebaseErrorHandler.handleFirebaseError(e));
    }
  }

}