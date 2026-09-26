import 'package:auto_sparkle/common/extensions.dart';
import 'package:auto_sparkle/common/navigator/transition_direction_enum.dart';
import 'package:flutter/material.dart';

class AnimatedMaterialPageRoute<T> extends PageRoute<T> {
  final Widget widget;
  final Color transitionColor;
  final TransitionDirection direction;

  AnimatedMaterialPageRoute({
    required this.widget,
    required this.transitionColor,
    this.direction = TransitionDirection.ltr,
    RouteSettings? settings,
  }) : super(settings: settings ?? const RouteSettings());

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    if (settings.name?.equals('/') ?? false) return widget;

    final Offset begin = direction.offset;
    const Offset end = Offset.zero;
    const Curve curve = Curves.easeIn;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: widget,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  Color? get barrierColor => transitionColor;

  @override
  String? get barrierLabel => null;
}
