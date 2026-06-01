import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../../services/favorite_service.dart';
import '../../home/controllers/home_controller.dart';

class FavouritesController extends GetxController {

  final HomeController homeController =
  Get.find<HomeController>();
  late final FavoriteService favoriteService;


  @override
  void onInit() {
    favoriteService = Get.find<FavoriteService>();
    super.onInit();
  }

  List<ProductModel> get favoriteProducts {
    return homeController.products
        .where(
          (product) => favoriteService
          .favoriteIds
          .contains(product.id),
    )
        .toList();
  }
}
