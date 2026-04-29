import 'package:flutter/foundation.dart';
import '../models/product.dart';

class FavoritesProvider with ChangeNotifier {
  final Set<String> _favoriteIds = {};

  bool isFavorite(String productId) => _favoriteIds.contains(productId);

  void toggleFavorite(Product product) {
    if (_favoriteIds.contains(product.id)) {
      _favoriteIds.remove(product.id);
      product.isFavorite = false;
    } else {
      _favoriteIds.add(product.id);
      product.isFavorite = true;
    }
    notifyListeners();
  }

  List<Product> filterFavorites(List<Product> products) {
    return products
        .where((product) => _favoriteIds.contains(product.id))
        .toList();
  }
}
