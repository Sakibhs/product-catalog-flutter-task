import 'package:get/get.dart';

import 'package:dio/dio.dart';
import '../data/providers/dio_provider.dart';
import '../data/repositories/product_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(
          () => DioProvider.createDio(),
      fenix: true,
    );

    Get.lazyPut<ProductRepository>(
          () => ProductRepository(
        dio: Get.find<Dio>(),
      ),
      fenix: true,
    );
  }
}