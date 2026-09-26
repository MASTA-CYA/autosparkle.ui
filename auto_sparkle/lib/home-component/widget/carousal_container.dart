import 'package:flutter/material.dart';

class CarousalContainerWidget extends StatelessWidget {
  final Widget header;
  final Widget body;

  const CarousalContainerWidget({
    super.key,
    required this.header,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: const [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(child: body),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 40,
      color: Theme.of(context).colorScheme.primary,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: header,
      ),
    );
  }
}
