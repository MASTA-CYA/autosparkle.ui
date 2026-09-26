import 'package:flutter/material.dart';
import 'package:auto_sparkle/common/functions.dart';
import 'package:auto_sparkle/common/widgets/page_section_header.dart';

class PageSectionWidget extends StatefulWidget {
  final bool? startExpanded;
  final String title;
  final Widget child;

  const PageSectionWidget({
    super.key,
    this.startExpanded,
    required this.title,
    required this.child,
  });

  @override
  State<PageSectionWidget> createState() => _PageSectionWidgetState();
}

class _PageSectionWidgetState extends State<PageSectionWidget> {
  late bool _isVisible;

  @override
  void initState() {
    super.initState();

    _isVisible = widget.startExpanded ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PageSectionHeaderWidget(
          startExpanded: widget.startExpanded,
          title: widget.title,
          onSectionExpanded: (isExpanded) => _onSectionExpanded(isExpanded),
        ),
        Visibility(
          visible: _isVisible,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: Functions.horizontalScreenMargin(context),
                vertical: 4,
              ),
              child: widget.child,
            ),
          ),
        ),
      ],
    );
  }

  void _onSectionExpanded(bool isExpanded) {
    setState(() {
      _isVisible = isExpanded;
    });
  }
}
