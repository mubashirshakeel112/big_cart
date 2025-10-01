import 'package:big_cart/domain/models/users_model.dart';
import 'package:big_cart/services/users_service.dart';

class UsersRepository extends UsersService{
  final WCUsersService _wcUsersService = WCUsersService();
  @override
  Future<void> setUser(UsersModel users) async{
    await _wcUsersService.setUser(users);
  }

  @override
  Future<UsersModel> getUser(String id) async{
    return await _wcUsersService.getUser(id);
  }
}