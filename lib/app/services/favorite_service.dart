import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService extends GetxService {
  static const String favoriteKey = "favorite_products";

  final RxSet<int> favoriteIds = <int>{}.obs;

  Future<FavoriteService> init() async {
    await loadFavorites();
    return this;
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> storedIds =
        prefs.getStringList(favoriteKey) ?? [];

    favoriteIds.assignAll(
      storedIds.map(int.parse),
    );
  }

  Future<void> toggleFavorite(int productId) async {
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
    } else {
      favoriteIds.add(productId);
    }

    await _saveFavorites();
  }

  bool isFavorite(int productId) {
    return favoriteIds.contains(productId);
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      favoriteKey,
      favoriteIds.map((e) => e.toString()).toList(),
    );
  }
}