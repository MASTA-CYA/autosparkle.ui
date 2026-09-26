import 'package:auto_sparkle/shop-component/models/product_variation_model.dart';

class Product {
  final int id;
  final String image;
  final String name;
  final String description;
  final String quantity;
  final double price;
  final List<ProductVariation>? variations;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    this.variations,
  });
}
