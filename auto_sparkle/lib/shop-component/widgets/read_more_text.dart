import 'package:flutter/material.dart';
import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/common/functions.dart';

class ReadMoreTextWidget extends StatefulWidget {
  final String text;
  final TextStyle style;
  const ReadMoreTextWidget({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  State<StatefulWidget> createState() => _ReadMoreTextWidget();
}

class _ReadMoreTextWidget extends State<ReadMoreTextWidget> {
  final ValueNotifier _isExpanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final bool hasOverflow = Functions.hasTextOverflow(
      text: widget.text,
      style: widget.style,
      maxWidth: MediaQuery.of(context).size.width,
    );

    return ValueListenableBuilder(
      valueListenable: _isExpanded,
      builder: (context, isExpanded, child) => Wrap(
        children: [
          Text(
            widget.text,
            maxLines: isExpanded ? 5 : 2,
            overflow: TextOverflow.ellipsis,
            style: widget.style,
          ),
          if (hasOverflow) ...{
            Container(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                child: Text(
                  isExpanded ? "Read less" : "Read more",
                  style: Theme.of(context).textTheme.titleSmall?.merge(
                        TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: FontFamily.PRIMARY,
                        ),
                      ),
                ),
                onTap: () => _isExpanded.value = !isExpanded,
              ),
            ),
          }
        ],
      ),
    );
  }
}
