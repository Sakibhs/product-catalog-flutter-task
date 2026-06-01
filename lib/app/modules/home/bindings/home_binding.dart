import 'package:get/get.dart';

import '../../../data/repositories/product_repository.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(repository: Get.find<ProductRepository>()),
    );
  }
}
