import 'package:flutter/material.dart';

class NamedPageRoute {
  final String name;
  final Widget widget;

  const NamedPageRoute({
    required this.name,
    required this.widget,
  });

  String get path => '/$name';
}
