import 'package:get/get.dart';

import 'package:dio/dio.dart';
import '../data/providers/dio_provider.dart';
import '../data/repositories/product_repository.dart';
import '../services/favorite_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Register FavoriteService synchronously so it's available immediately
    Get.put<FavoriteService>(FavoriteService());

    // Initialize FavoriteService data in background
    Get.find<FavoriteService>().init();

    Get.lazyPut<Dio>(() => DioProvider.createDio(), fenix: true);
    Get.lazyPut<ProductRepository>(
      () => ProductRepository(dio: Get.find<Dio>()),
      fenix: true,
    );
  }
}
