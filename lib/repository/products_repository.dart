import 'package:big_cart/domain/models/products_model.dart';
import 'package:big_cart/services/products_service.dart';

class ProductsRepository extends ProductsService{
  final WCProductsService _wcProductsService = WCProductsService();
  @override
  Future<List<ProductsModel>> getProducts() async{
    return await _wcProductsService.getProducts();
  }

  @override
  Future<ProductsModel> getProductById(String id) async{
    return await _wcProductsService.getProductById(id);
  }

  @override
  Future<List<ProductsModel>> getProductsByCategory(String category) async{
    return await _wcProductsService.getProductsByCategory(category);
  }
}