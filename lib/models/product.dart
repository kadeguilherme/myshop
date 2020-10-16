import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String title;
  final String descripton;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.descripton,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });
}
