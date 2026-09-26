import 'package:auto_sparkle/common/helpers/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/common/extensions.dart';

class PageSectionHeaderWidget extends StatefulWidget {
  final bool? startExpanded;
  final String title;
  final Function(bool isExpanded)? onSectionExpanded;

  const PageSectionHeaderWidget({
    super.key,
    this.startExpanded,
    required this.title,
    this.onSectionExpanded,
  });

  @override
  State<PageSectionHeaderWidget> createState() =>
      _PageSectionHeaderWidgetState();
}

class _PageSectionHeaderWidgetState extends State<PageSectionHeaderWidget> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();

    _isExpanded = widget.startExpanded ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium?.merge(
                      TextStyle(
                        fontFamily: FontFamily.PRIMARY,
                        color: _isExpanded
                            ? ColorHelper.lighten(
                                Theme.of(context).primaryColor, 30)
                            : null,
                      ),
                    ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return GestureDetector(
                    child: _isExpanded
                        ? Icon(
                            Icons.keyboard_arrow_down,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : const Icon(Icons.keyboard_arrow_up),
                    onTap: () async => onIconExpanded(setState),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onIconExpanded(StateSetter iconSetState) async {
    if (!widget.onSectionExpanded.isNull) {
      widget.onSectionExpanded!(!_isExpanded);
    }
    iconSetState(
      () {
        _isExpanded = !_isExpanded;
      },
    );
  }
}
