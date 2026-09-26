import 'package:auto_sparkle/home-component/models/carousal_item_model.dart';
import 'package:flutter/material.dart';

class BusinessFeature implements CarousalItem {
  final String icon;
  final String name;
  final Widget description;

  BusinessFeature({
    required this.icon,
    required this.name,
    required this.description,
  });
}
