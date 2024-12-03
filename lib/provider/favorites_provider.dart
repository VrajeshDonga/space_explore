import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesProvider extends ChangeNotifier {
  final Box favoritesBox;

  FavoritesProvider(this.favoritesBox);

  // Add item to favorites
  void addFavorite(String key, dynamic item) {
    favoritesBox.put(key, item);
    notifyListeners();
  }

  // Remove item from favorites
  void removeFavorite(String key) {
    favoritesBox.delete(key);
    notifyListeners();
  }

  // Check if an item is a favorite
  bool isFavorite(String key) {
    return favoritesBox.containsKey(key);
  }

  // Get all favorites
  List<dynamic> get allFavorites => favoritesBox.values.toList();
}
