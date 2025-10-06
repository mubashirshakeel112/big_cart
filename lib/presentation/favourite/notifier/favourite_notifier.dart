import 'package:big_cart/domain/models/favourite_model.dart';
import 'package:big_cart/domain/models/products_model.dart';
import 'package:big_cart/repository/favourite_repository.dart';
import 'package:big_cart/repository/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouriteProvider = StateNotifierProvider<FavouriteNotifier, FavouriteState>((ref) {
  return FavouriteNotifier();
});

class FavouriteNotifier extends StateNotifier<FavouriteState> {
  FavouriteNotifier() : super(FavouriteState.initialize());

  final FavouriteRepository _favouriteRepository = FavouriteRepository();
  final ProductsRepository _productsRepository = ProductsRepository();

  setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<void> postFavourite(String productId) async {
    try {
      // ✅ Optimistic Update
      if (isFavourite(productId)) {
        // remove from local state immediately
        state = state.copyWith(
          favourites: state.favourites.where((fav) => fav.id != productId).toList(),
        );

        await _favouriteRepository.deleteFavourite(productId);
      } else {
        final product = await _productsRepository.getProductById(productId);

        state = state.copyWith(
          favourites: [...state.favourites, product],
        );

        final favourite = FavouriteModel(id: productId, createdAt: DateTime.now());
        await _favouriteRepository.postFavourite(favourite);
      }
    } catch (e) {
      await getFavourites();
      throw Exception(e.toString());
    }
  }

  Future<void> getFavourites() async {
    try {
      setLoading(true);
      final favouriteDocs  = await _favouriteRepository.getFavourite();
      List<ProductsModel> favProducts = [];
      for(var fav in favouriteDocs){
        final codeSnap = await  _productsRepository.getProductById(fav.id);
        if(codeSnap.id.isNotEmpty){
          favProducts.add(codeSnap);
        }
      }
      state = state.copyWith(favourites: favProducts);
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteFavourite(String id) async{
    try{
      await _favouriteRepository.deleteFavourite(id);
      await getFavourites();
    }catch(e){
      throw Exception(e.toString());
    }
  }

  bool isFavourite(String productId) {
    return state.favourites.any((fav) => fav.id == productId);
  }
}

class FavouriteState {
  bool isLoading;
  List<ProductsModel> favourites;

  FavouriteState({required this.isLoading, required this.favourites});

  FavouriteState copyWith({bool? isLoading, List<ProductsModel>? favourites}) {
    return FavouriteState(isLoading: isLoading ?? this.isLoading, favourites: favourites ?? this.favourites);
  }

  factory FavouriteState.initialize() {
    return FavouriteState(isLoading: false, favourites: []);
  }
}
