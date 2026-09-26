import 'package:auto_sparkle/common/extensions.dart';

enum MessageSeverity {
  critical,
  information,
  warning,
  alert;

  static MessageSeverity fromJson(String json) => values.byName(json);
  String toJson() => name;

  /// Human readable label, e.g. "Information".
  String get displayName => name.capitalize();
}
