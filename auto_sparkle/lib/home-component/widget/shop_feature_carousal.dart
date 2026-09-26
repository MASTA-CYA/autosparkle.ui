import 'package:auto_sparkle/home-component/models/business_feature_model.dart';
import 'package:auto_sparkle/home-component/models/carousal_item_model.dart';
import 'package:auto_sparkle/home-component/models/shop_product_summary.dart';
import 'package:auto_sparkle/home-component/widget/business_feature.dart';
import 'package:auto_sparkle/home-component/widget/shop_product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ShopFeatureWidget extends StatefulWidget {
  final List<CarousalItem> items;
  final void Function() onOrderNowPressed;

  const ShopFeatureWidget({
    super.key,
    required this.items,
    required this.onOrderNowPressed,
  });

  @override
  State<StatefulWidget> createState() => _ShopFeatureWidget();
}

class _ShopFeatureWidget extends State<ShopFeatureWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 6),
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        clipBehavior: Clip.none,
      ),
      items: widget.items.map((item) => _mapCarousalItems(item)).toList(),
    );
  }

  Widget _mapCarousalItems(CarousalItem item) {
    Widget widget;

    switch (item.runtimeType) {
      case const (ShopProductSummary):
        widget = ShopProductWidget(
          product: item as ShopProductSummary,
          onOrderNowPressed: this.widget.onOrderNowPressed,
        );
        break;
      case const (BusinessFeature):
        widget = BusinessFeatureWidget(
          feature: item as BusinessFeature,
        );
        break;
      default:
        widget = const SizedBox.shrink();
    }

    return widget;
  }
}
