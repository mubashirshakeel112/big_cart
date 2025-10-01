import 'package:big_cart/domain/models/products_model.dart';
import 'package:big_cart/repository/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsCategoryProvider = FutureProvider.family<List<ProductsModel>, String>((ref, category) async{
  final ProductsRepository productsRepository = ProductsRepository();
  final result = await productsRepository.getProductsByCategory(category);
  return result;
});