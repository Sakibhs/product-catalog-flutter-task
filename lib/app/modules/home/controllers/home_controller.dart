import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../services/favorite_service.dart';

class HomeController extends GetxController {
  HomeController({required ProductRepository repository})
    : _repository = repository;

  final ProductRepository _repository;

  final screenState = ScreenState.initial.obs;
  final products = <ProductModel>[].obs;
  final filteredProducts = <ProductModel>[].obs;
  final errorMessage = ''.obs;
  final searchController = TextEditingController();
  late final FavoriteService favoriteService;

  @override
  void onInit() {
    super.onInit();
    favoriteService = Get.find<FavoriteService>();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      screenState.value = ScreenState.loading;

      final result = await _repository.getProducts();

      if (result.isEmpty) {
        screenState.value = ScreenState.empty;
        return;
      }

      products.assignAll(result);
      filteredProducts.assignAll(result);
      screenState.value = ScreenState.success;
    } catch (e, s) {
      log('Error fetching products: $e', stackTrace: s);
      errorMessage.value = e.toString();
      screenState.value = ScreenState.error;
    }
  }

  void searchProducts(String query) {
    if (query.trim().isEmpty) {
      filteredProducts.assignAll(products);
      return;
    }

    filteredProducts.assignAll(
      products.where(
        (product) =>
            (product.title ?? '').toLowerCase().contains(query.toLowerCase()) ||
            (product.category ?? '').toLowerCase().contains(
              query.toLowerCase(),
            ),
      ),
    );
    if (filteredProducts.isEmpty) {
      screenState.value = ScreenState.empty;
    } else {
      screenState.value = ScreenState.success;
    }
  }

  Future<void> toggleFavorite(int productId) async {
    await favoriteService.toggleFavorite(productId);
  }

  bool isFavorite(int productId) {
    return favoriteService.isFavorite(productId);
  }
}

enum ScreenState { initial, loading, success, empty, error }
