import 'package:auto_sparkle/common/extensions.dart';
import 'package:flutter/material.dart';

enum WashStatus {
  cancelled,
  paid,
  pending,
}

extension WashStatusExtensions on WashStatus {
  String get displayName => _getDisplayName();
  Color get color => _getStatusColor();

  String _getDisplayName() {
    switch (this) {
      case WashStatus.pending:
        return 'Pending Payment';
      default:
        return name.capitalize();
    }
  }

  Color _getStatusColor() {
    switch (this) {
      case WashStatus.cancelled:
        return Colors.red;
      case WashStatus.paid:
        return Colors.green;
      case WashStatus.pending:
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}
