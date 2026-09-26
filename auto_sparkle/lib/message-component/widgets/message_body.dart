import 'package:auto_sparkle/common/helpers/color_helper.dart';
import 'package:flutter/material.dart';

class MessageBodyWidget extends StatelessWidget {
  final String body;

  const MessageBodyWidget({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = BorderSide(
      color: Theme.of(context).brightness == Brightness.light
          ? ColorHelper.lighten(Theme.of(context).colorScheme.secondary, 70)
          : Theme.of(context).colorScheme.secondary.withValues(alpha: 0.4),
      width: 5,
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: borderSide,
          right: borderSide,
          bottom: borderSide,
        ),
      ),
      child: Row(
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(6),
              child: Text(body),
            ),
          ),
        ],
      ),
    );
  }
}
