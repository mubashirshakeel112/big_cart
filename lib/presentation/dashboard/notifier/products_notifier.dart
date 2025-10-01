import 'package:big_cart/domain/models/products_model.dart';
import 'package:big_cart/repository/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  return ProductsNotifier();
});

final cardUpdate = StateProvider.family<bool, String>((ref, productId){
  return false;
});

class ProductsNotifier extends StateNotifier<ProductsState> {
  ProductsNotifier() : super(ProductsState.initialize());

  final ProductsRepository _productsRepository = ProductsRepository();

  setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  setProducts(List<ProductsModel> value) {
    state = state.copyWith(products: value, filteredProducts: value);
  }

  Future<void> getProducts() async {
    try {
      setLoading(true);
      final result = await _productsRepository.getProducts();
      setProducts(result);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading(false);
    }
  }

  /// 🔍 Search filter
  void filterProducts(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredProducts: state.products);
    } else {
      final lowerQuery = query.toLowerCase();

      final results = state.products.where((product) {
        final titleMatch = product.title.toLowerCase().contains(lowerQuery);
        final subtitleMatch = product.subtitle.toLowerCase().contains(lowerQuery);
        final categoryMatch = product.categories.toLowerCase().contains(lowerQuery);

        return titleMatch || subtitleMatch || categoryMatch;
      }).toList();

      state = state.copyWith(filteredProducts: results);
    }
  }

// void filterProducts(String query) {
  //   if (query.isEmpty) {
  //     state = state.copyWith(filteredProducts: state.products);
  //   } else {
  //     final results = state.products.where((product) =>
  //         product.title.toLowerCase().contains(query.toLowerCase())
  //     ).toList();
  //
  //     state = state.copyWith(filteredProducts: results);
  //   }
  // }
}

class ProductsState {
  bool isLoading;
  List<ProductsModel> products;
  List<ProductsModel> filteredProducts;

  ProductsState({
    required this.isLoading,
    required this.products,
    required this.filteredProducts,
  });

  ProductsState copyWith({
    bool? isLoading,
    List<ProductsModel>? products,
    List<ProductsModel>? filteredProducts,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
    );
  }

  factory ProductsState.initialize() {
    return ProductsState(isLoading: false, products: [], filteredProducts: []);
  }
}