import 'package:big_cart/domain/models/products_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProductsService {
  Future<List<ProductsModel>> getProducts();
  Future<ProductsModel> getProductById(String id);
  Future<List<ProductsModel>> getProductsByCategory(String category);
}

class WCProductsService extends ProductsService {
  final ref =  FirebaseFirestore.instance.collection('products');
  @override
  Future<List<ProductsModel>> getProducts() async {
    final products = await ref.get();
    try{
      return products.docs.map((e) => ProductsModel.fromJson(e.data())).toList();
    }catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Future<ProductsModel> getProductById(String id) async{
    final product = await ref.doc(id).get();
   try{
     return ProductsModel.fromJson(product.data()!);
   }catch(e){
     throw Exception(e.toString());
   }
  }

  @override
  Future<List<ProductsModel>> getProductsByCategory(String category) async{
    final productCategory = await ref.where('category', isEqualTo: category).get();
    return productCategory.docs.map(
        (e)=> ProductsModel.fromJson(e.data())
    ).toList();
  }
}
