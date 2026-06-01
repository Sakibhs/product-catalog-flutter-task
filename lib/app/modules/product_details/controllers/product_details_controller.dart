import 'package:get/get.dart';
import '../../../services/favorite_service.dart';

class ProductDetailsController extends GetxController {
  late final FavoriteService favoriteService;

  @override
  void onInit() {
    super.onInit();
    favoriteService = Get.find<FavoriteService>();
  }

  bool isFavorite(int productId) {
    return favoriteService.isFavorite(productId);
  }

  Future<void> toggleFavorite(int productId) async {
    await favoriteService.toggleFavorite(productId);
  }
}
