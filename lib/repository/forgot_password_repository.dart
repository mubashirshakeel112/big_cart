import 'package:big_cart/services/forgot_password_service.dart';

class ForgotPasswordRepository extends ForgotPasswordService{
  final WCForgotPasswordService _wcForgotPasswordService = WCForgotPasswordService();
  @override
  Future<bool> forgotPassword(String email) async{
    return await _wcForgotPasswordService.forgotPassword(email);
  }
}