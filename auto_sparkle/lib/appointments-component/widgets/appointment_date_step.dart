import 'dart:math';

import 'package:auto_sparkle/appointments-component/models/calendar_day_model.dart';
import 'package:auto_sparkle/appointments-component/widgets/calendar_day.dart';
import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/common/helpers/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentDateStepWidget extends StatefulWidget {
  const AppointmentDateStepWidget({super.key});

  @override
  State<StatefulWidget> createState() => _AppointmentDateStepWidget();
}

class _AppointmentDateStepWidget extends State<AppointmentDateStepWidget> {
  late Map<String, List<CalendarDay?>> _calendarMonth;
  late int _currentMonth;
  CalendarDay? _selectedDay;
  DateTime? _selectedDate;

  late List<String> _timeSlots;

  @override
  void initState() {
    super.initState();

    _timeSlots = _getOperatingHours();
    _calendarMonth = _getCalendar(null);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildDate(),
          const SizedBox(height: 10),
          _buildTimeDropdown(),
        ],
      ),
    );
  }

  Widget _buildDate() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Appointment Date',
            style: Theme.of(context).textTheme.labelMedium?.merge(
                  const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ),
        const SizedBox(height: 4),
        _buildCalendarHeader(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          child: _buildCalendar(_calendarMonth),
        ),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: ColorHelper.lighten(Theme.of(context).colorScheme.secondary, 85),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => onCalendarMonthChanged(false),
          ),
          Text(
            DateFormat.MMMM()
                .format(DateTime(DateTime.now().year, _currentMonth)),
            style: Theme.of(context).textTheme.titleLarge?.merge(
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => onCalendarMonthChanged(true),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(Map<String, List<CalendarDay?>> calendarMonth) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: calendarMonth.keys
            .map(
              (key) => Column(
                children: [
                  Text(
                    key.characters.first,
                    style: key == 'Sunday'
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          )
                        : const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: calendarMonth[key]!
                        .map(
                          (e) => CalendarDayWidget(
                            date: e,
                            isCurrentDate: DateTime.now().day == e?.day &&
                                key ==
                                    DateFormat('EEEE').format(DateTime.now()),
                            isSelected: _selectedDay?.day == e?.day,
                            isClosed: key == 'Sunday',
                            onDaySelected: (day) => _onDaySelected(day),
                            size: Size(
                              (constraints.maxWidth / 7) - 5,
                              (constraints.maxHeight /
                                      calendarMonth[key]!.length) -
                                  5,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildTimeDropdown() {
    return DropdownButtonFormField(
      isDense: true,
      isExpanded: true,
      icon: const Icon(Icons.arrow_downward),
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints(maxHeight: 35),
        prefixIcon: Container(
          margin: const EdgeInsets.all(6),
          child: const ImageIcon(
            ResizeImage(
              AssetImage('assets/images/time.png'),
              width: 70,
              height: 70,
              allowUpscaling: false,
            ),
          ),
        ),
        labelText: 'Time Slot',
        labelStyle: Theme.of(context).textTheme.bodyLarge?.merge(
              const TextStyle(
                fontFamily: FontFamily.PRIMARY,
              ),
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
        ),
      ),
      items: _timeSlots.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      initialValue: _timeSlots.first,
      onChanged: (String? value) {},
    );
  }

  List<String> _getOperatingHours() {
    List<String> slots = [];
    DateTime now = DateTime.now();
    DateTime start = DateTime(now.year, now.month, now.day, 7);

    for (int i = 0; i < 26; i++) {
      if (Random().nextBool()) {
        slots.add(DateFormat('Hm').format(start));
      }
      start = start.add(const Duration(minutes: 30));
    }

    return slots;
  }

  Map<String, List<CalendarDay?>> _getCalendar(int? month) {
    DateTime dateNow = DateTime.now();
    _currentMonth = month ?? dateNow.month;
    DateTime calendarMonth = DateTime(dateNow.year, _currentMonth);

    int totalDays = _daysInMonth(calendarMonth);

    List<int> listOfDates = List<int>.generate(totalDays, (i) => i + 1);

    Map<String, List<CalendarDay?>> calendar = {
      'Monday': [],
      'Tuesday': [],
      'Wednesday': [],
      'Thursday': [],
      'Friday': [],
      'Saturday': [],
      'Sunday': [],
    };

    List<int> daysToPad = _getDaysToPad(
      DateTime(
        calendarMonth.year,
        calendarMonth.month,
        1,
      ),
    );

    for (var e in listOfDates) {
      DateTime date = DateTime(calendarMonth.year, calendarMonth.month, e);
      calendar.update(
        DateFormat('EEEE').format(date),
        (value) {
          int available = date.weekday != 7 ? Random().nextInt(9) : 0;
          int unavailable = date.weekday != 7 ? (8 - available) : 0;

          daysToPad.contains(date.weekday) && date.day <= 7
              ? value.addAll(
                  [
                    null,
                    CalendarDay(
                      day: e,
                      availableSlots: available,
                      unavailableSlots: unavailable,
                    ),
                  ],
                )
              : value.add(
                  CalendarDay(
                    day: e,
                    availableSlots: available,
                    unavailableSlots: unavailable,
                  ),
                );
          return value;
        },
      );
    }

    if (_currentMonth == DateTime.now().month) {
      _selectedDay = calendar[DateFormat('EEEE').format(DateTime.now())]
          ?.firstWhere((element) => element?.day == DateTime.now().day);
      _selectedDate = DateTime.now();
    } else {
      _selectedDay = calendar[DateFormat('EEEE').format(
        DateTime(
            DateTime.now().year,
            _selectedDay!.day == 31 ? _currentMonth + 1 : _currentMonth,
            _selectedDay!.day == 31 ? 0 : _selectedDay!.day),
      )]
          ?.firstWhere(
        (element) =>
            element?.day ==
            (_selectedDay!.day == 31
                ? DateTime(
                        DateTime.now().year,
                        _selectedDay!.day == 31
                            ? _currentMonth + 1
                            : _currentMonth,
                        _selectedDay!.day == 31 ? 0 : _selectedDay!.day)
                    .day
                : _selectedDay!.day),
      );
      _selectedDate =
          DateTime(DateTime.now().year, _currentMonth, _selectedDay!.day);
    }

    return calendar;
  }

  int _daysInMonth(DateTime date) {
    DateTime firstDayThisMonth = DateTime(date.year, date.month, date.day);
    DateTime firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);

    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  void onCalendarMonthChanged(bool isForward) {
    setState(
      () {
        _calendarMonth = _getCalendar(isForward
            ? _currentMonth == 12
                ? 1
                : _currentMonth + 1
            : _currentMonth == 1
                ? 12
                : _currentMonth - 1);
      },
    );
  }

  List<int> _getDaysToPad(DateTime date) {
    switch (date.weekday) {
      case DateTime.tuesday:
        return [DateTime.monday];
      case DateTime.wednesday:
        return [DateTime.monday, DateTime.tuesday];
      case DateTime.thursday:
        return [DateTime.monday, DateTime.tuesday, DateTime.wednesday];
      case DateTime.friday:
        return [
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
        ];
      case DateTime.saturday:
        return [
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
          DateTime.friday,
        ];
      case DateTime.sunday:
        return [
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
          DateTime.friday,
          DateTime.saturday,
        ];

      default:
        return [];
    }
  }

  void _onDaySelected(CalendarDay day) {
    setState(
      () {
        _selectedDay = day;
        _selectedDate =
            DateTime(_selectedDate!.year, _currentMonth, _selectedDay!.day);
      },
    );
  }
}
