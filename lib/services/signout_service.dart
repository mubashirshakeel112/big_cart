import 'package:firebase_auth/firebase_auth.dart';

abstract class SignOutService{
  Future<bool> signOut();
}

class WCSignOutService extends SignOutService{
  @override
  Future<bool> signOut() async{
    try{
      await FirebaseAuth.instance.signOut();
      return true;
    }catch(e){
      throw Exception(e.toString());
    }
  }
}