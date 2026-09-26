import 'package:auto_sparkle/appointments-component/enums/package_actions.dart';
import 'package:flutter/material.dart';

class WashPackage {
  final int id;
  final String name;
  final Color color;
  final List<PackageAction> actions;
  final double price;

  WashPackage({
    required this.id,
    required this.name,
    required this.color,
    required this.actions,
    required this.price,
  });
}
