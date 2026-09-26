import 'package:auto_sparkle/common/extensions.dart';

enum PackageAction {
  vacuum,
  dashboard,
  wash,
  dry,
  polish,
  tyres,
}

extension PackageActionsExtension on PackageAction {
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
      default:
        return name;
    }
  }
}
