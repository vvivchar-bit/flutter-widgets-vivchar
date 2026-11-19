import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/product.dart';

class AppState extends ChangeNotifier {
  List<Product> _favoriteProducts = [];
  User? _currentUser;
  int _cartItemsCount = 0;

  List<Product> get favoriteProducts =>
      List.unmodifiable(_favoriteProducts);

  User? get currentUser => _currentUser;

  int get cartItemsCount => _cartItemsCount;

  void updateUser(User user) {
    if (user.name.trim().isEmpty || !user.email.contains('@')) {
      throw ArgumentError('Invalid user data');
    }

    _currentUser = user;
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favoriteProducts.any((p) => p.id == product.id);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      _favoriteProducts = _favoriteProducts
          .where((p) => p.id != product.id)
          .toList();
    } else {
      _favoriteProducts = [..._favoriteProducts, product];
    }

    notifyListeners();
  }

  void addToCart(Product product) {
    if (!product.price.isFinite || product.price < 0) {
      throw ArgumentError('Invalid product price');
    }

    _cartItemsCount++;
    notifyListeners();
  }

  void clearCart() {
    _cartItemsCount = 0;
    notifyListeners();
  }
}