import 'package:big_cart/services/signout_service.dart';

class SignOutRepository extends SignOutService{
  final WCSignOutService _wcSignOutService = WCSignOutService();
  @override
  Future<bool> signOut() async{
    return _wcSignOutService.signOut();
  }
}