import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catelog/app/modules/favourites/controllers/favourites_controller.dart';

import '../../home/widgets/product_card.dart';

class FavouritesView extends GetView<FavouritesController> {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Products')),
      body: Obx(() {
        final products = controller.favoriteProducts;

        if (products.isEmpty) {
          return Center(
            child: Text(
              'No favorite products yet.',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) {
            final product = products[index];

            return ProductCard(
              title: product.title ?? "",
              image: product.image ?? "",
              price: '\$${product.price}',
              rating:
                  '${product.rating?.rate ?? 0} (${product.rating?.count ?? 0})',
              isFavorite: true,
              onFavoriteTap: () {
                controller.favoriteService.toggleFavorite(product.id ?? -1);
              },
              onTap: () {},
            );
          },
        );
      }),
    );
  }
}
