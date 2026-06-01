import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:product_catelog/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

import 'package:flutter/material.dart';

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
              // Navigate to favorites
            },
            icon: const Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: Obx(
          () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  // Search logic
                },
              ),
            ),
            if(controller.screenState.value == ScreenState.loading || controller.screenState.value == ScreenState.initial)
              const Center(child: CircularProgressIndicator()),
            if(controller.screenState.value == ScreenState.error)
              const Center(child: Text('Failed to load products')),
            if(controller.screenState.value == ScreenState.empty)
              const Center(child: Text('No products found')),
            if(controller.screenState.value == ScreenState.success)
              Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.products.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, index) {
                  return ProductCard(
                    title: controller.products[index].title ?? 'Product Name',
                    price: controller.products[index].price != null ? '\$${controller.products[index].price}' : '\$0.00',
                    rating: controller.products[index].rating?.rate != null ? controller.products[index].rating!.rate.toString() : '0.0',
                    image: controller.products[index].image ?? 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                    isFavorite: controller.products[index].isFavorite ?? false,
                    onFavoriteTap: () {},
                    onTap: () {
                      Get.toNamed(Routes.PRODUCT_DETAILS, arguments: controller.products[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
