import 'package:big_cart/domain/models/products_model.dart';
import 'package:big_cart/repository/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailedProvider = FutureProvider.family<ProductsModel, String>((ref, id) async{
  final ProductsRepository productsRepository = ProductsRepository();
  final result = await productsRepository.getProductById(id);
  return result;
});