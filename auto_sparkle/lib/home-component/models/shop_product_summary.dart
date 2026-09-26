import 'package:auto_sparkle/home-component/models/carousal_item_model.dart';

class ShopProductSummary implements CarousalItem {
  final String name;
  final String image;
  final String quality;
  final double price;

  ShopProductSummary({
    required this.name,
    required this.image,
    required this.quality,
    required this.price,
  });
}
