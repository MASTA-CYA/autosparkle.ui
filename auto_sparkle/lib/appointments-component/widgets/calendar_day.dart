import 'package:auto_sparkle/appointments-component/models/calendar_day_model.dart';
import 'package:auto_sparkle/common/helpers/color_helper.dart';
import 'package:flutter/material.dart';

class CalendarDayWidget extends StatefulWidget {
  final Size size;
  final CalendarDay? date;
  final bool isCurrentDate;
  final bool isSelected;
  final bool isClosed;
  final void Function(CalendarDay day)? onDaySelected;

  const CalendarDayWidget({
    super.key,
    required this.size,
    this.date,
    required this.isCurrentDate,
    required this.isSelected,
    required this.isClosed,
    this.onDaySelected,
  });

  @override
  State<StatefulWidget> createState() => _CalendarDayWidget();
}

class _CalendarDayWidget extends State<CalendarDayWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: widget.date == null
          ? const SizedBox.shrink()
          : GestureDetector(
              child: Container(
                margin: const EdgeInsets.all(3),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: widget.isSelected
                            ? ColorHelper.lighten(
                                Theme.of(context).primaryColor,
                                85,
                              )
                            : null,
                        border: Border.all(
                          width: 2,
                          color: widget.isSelected
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        child: Text(
                          widget.date?.day.toString() ?? '',
                          style: Theme.of(context).textTheme.titleMedium?.merge(
                                TextStyle(
                                  fontWeight: widget.isCurrentDate
                                      ? FontWeight.bold
                                      : null,
                                  color: widget.isCurrentDate
                                      ? Theme.of(context).primaryColor
                                      : widget.isClosed
                                          ? Colors.red
                                          : null,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () => widget.onDaySelected!(widget.date!),
            ),
    );
  }
}
