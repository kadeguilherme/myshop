import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/product.dart';

import 'product.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.productId,
      @required this.price,
      @required this.quantity,
      @required this.title});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get item {
    return {..._items};
  }

  int get intemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0;

    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingItem) {
        return CartItem(
            id: existingItem.id,
            productId: product.id,
            price: existingItem.price,
            quantity: existingItem.quantity + 1,
            title: existingItem.title);
      });
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
            id: Random().nextDouble().toString(),
            price: product.price,
            productId: product.id,
            quantity: 1,
            title: product.title),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId].quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
          productId,
          (existingItem) => CartItem(
              id: existingItem.id,
              productId: existingItem.productId,
              price: existingItem.price,
              quantity: existingItem.quantity - 1,
              title: existingItem.title));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
