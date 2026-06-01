import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../../data/repositories/product_repository.dart';
class HomeController extends GetxController {
  HomeController({
    required ProductRepository repository,
  }) : _repository = repository;

  final ProductRepository _repository;

  final screenState = ScreenState.initial.obs;
  final products = <ProductModel>[].obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
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
      screenState.value = ScreenState.success;
    } catch (e, s) {
      log('Error fetching products: $e', stackTrace: s);
      errorMessage.value = e.toString();
      screenState.value = ScreenState.error;
    }
  }
}

enum ScreenState {
  initial,
  loading,
  success,
  empty,
  error,
}