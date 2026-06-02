import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:product_catelog/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import '../widgets/product_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.FAVOURITES);
            },
            icon: const Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.fetchProducts,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              controller.searchController.clear();
                              controller.searchProducts('');
                            },
                            icon: const Icon(Icons.clear),
                          )
                        : null,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: controller.searchProducts,
                ),
              ),
              if (controller.screenState.value == ScreenState.loading ||
                  controller.screenState.value == ScreenState.initial)
                const Padding(
                  padding: EdgeInsets.only(top: 48),
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (controller.screenState.value == ScreenState.error)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: const Center(child: Text('Failed to load products. Check Your internet connection and try again.')),
                ),
              if (controller.screenState.value == ScreenState.empty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: const Center(child: Text('No products found')),
                ),
              if (controller.screenState.value == ScreenState.success)
                Obx(
                  () => ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.filteredProducts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      return Obx(() {
                        final product = controller.filteredProducts[index];
                        final isFav = controller.isFavorite(product.id ?? -1);
                        return ProductCard(
                          title: product.title ?? 'Product Name',
                          price: product.price != null
                              ? '\$${product.price}'
                              : '\$0.00',
                          rating: product.rating?.rate != null
                              ? product.rating!.rate.toString()
                              : '0.0',
                          image:
                              product.image ??
                              'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                          isFavorite: isFav,
                          onFavoriteTap: () {
                            controller.toggleFavorite(product.id ?? -1);
                          },
                          onTap: () {
                            Get.toNamed(
                              Routes.PRODUCT_DETAILS,
                              arguments: product,
                            );
                          },
                        );
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
