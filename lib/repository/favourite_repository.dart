import 'package:big_cart/domain/models/favourite_model.dart';
import 'package:big_cart/services/favourite_service.dart';

class FavouriteRepository extends FavouriteService{
  final WCFavouriteService _wcFavouriteService = WCFavouriteService();
  @override
  Future<bool> postFavourite(FavouriteModel favourite) async{
    return await _wcFavouriteService.postFavourite(favourite);
  }

  @override
  Future<List<FavouriteModel>> getFavourite() async{
    return await _wcFavouriteService.getFavourite();
  }

  @override
  Future<void> deleteFavourite(String id) async{
    await _wcFavouriteService.deleteFavourite(id);
  }
}