import 'package:flutter/material.dart';

class BulletPointParagraphWidget extends StatelessWidget {
  final String paragraph;

  const BulletPointParagraphWidget({
    super.key,
    required this.paragraph,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> points = _getBulletPoints();
    return Column(
      children: points
          .map(
            (point) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('• '),
                Expanded(
                  child: Text(point),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  List<String> _getBulletPoints() {
    return paragraph.split('\n');
  }
}
