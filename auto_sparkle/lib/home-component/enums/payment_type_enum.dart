import 'package:auto_sparkle/common/extensions.dart';

enum PaymentMethod {
  cash,
  card,
  voucher,
}

extension PaymentMethodExtension on PaymentMethod {
  String get displayName => _getDisplayName();
  String get icon => _getIcon();

  String _getDisplayName() {
    switch (this) {
      default:
        return name.capitalize();
    }
  }

  String _getIcon() {
    switch (this) {
      case PaymentMethod.cash:
        return 'banknotes';
      default:
        return name;
    }
  }
}
