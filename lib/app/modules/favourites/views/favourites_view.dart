import 'package:flutter/material.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final hasData = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Products',
        ),
      ),
      body: hasData
          ? ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, __) =>
        const SizedBox(height: 12),
        itemBuilder: (_, index) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(14),
            ),
            tileColor: Colors.white,
            leading: Image.network(
              'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
              width: 60,
            ),
            title: const Text(
              'Product Name',
              maxLines: 2,
              overflow:
              TextOverflow.ellipsis,
            ),
            subtitle: const Text(
              '\$99.99',
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          );
        },
      )
          : const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 12),
            Text(
              'No favorites yet',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}