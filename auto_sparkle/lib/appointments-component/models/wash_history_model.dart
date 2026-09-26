import 'package:auto_sparkle/appointments-component/enums/wash_status_enum.dart';

class WashHistory {
  final String name;
  final String date;
  final String time;
  final String location;
  final String package;
  final WashStatus status;

  WashHistory({
    required this.name,
    required this.date,
    required this.time,
    required this.location,
    required this.package,
    required this.status,
  });
}
