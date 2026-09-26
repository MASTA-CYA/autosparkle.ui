import 'package:flutter/material.dart';
import 'package:auto_sparkle/common/logger/enums/severity_enum.dart';
import 'package:auto_sparkle/common/logger/enums/tag_enum.dart';
import 'package:auto_sparkle/common/logger/logger.dart';
import 'package:auto_sparkle/common/logger/models/log_event_model.dart';
import 'package:auto_sparkle/common/models/serializable_model.dart';

extension StringExtensions on String {
  /// Case-insensitive check that this string contains [other].
  bool containsIgnoreCase(String other) =>
      toLowerCase().contains(other.toLowerCase());

  /// Case-insensitive equality check.
  bool equals(String other) => toLowerCase() == other.toLowerCase();

  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) return this;
    return characters.first.toUpperCase() + characters.skip(1).join();
  }
}

extension ObjectExtensions on Object? {
  /// Checks if the object is null.
  bool get isNull => this == null;

  /// Equality check that also works on nullable values.
  bool equals(Object? other) => this == other;
}

extension SerializableListExtensions<T extends SerializableModel> on List<T> {
  /// Replaces [property] on the first element matching [find] with [value].
  /// If no element is found and [orElse] is null, nothing is replaced.
  /// Set [shouldThrowError] to rethrow any error caught during the operation.
  void modifyElement({
    required bool Function(T element) find,
    T Function()? orElse,
    required String property,
    required dynamic value,
    bool shouldThrowError = false,
  }) {
    try {
      T current = firstWhere(find, orElse: orElse);

      if (!current.keys.contains(property)) {
        throw Exception('Property "$property" does not exist on model: $T');
      }

      current = current.modifyProperty(property, value);
      replaceElement(find: find, element: current);
    } catch (ex) {
      Logger.logAsync(
        LogEvent<List<T>>(
          severity: Severity.error,
          tag: Tag.extension,
          line: ex.toString(),
        ),
      );
      if (shouldThrowError) rethrow;
    }
  }
}

extension ListExtensions<T> on List<T> {
  /// Replaces the first element matching [find] with [element].
  /// If no element is found and [orElse] is null, nothing is replaced.
  /// Set [shouldThrowError] to rethrow any error caught during the operation.
  void replaceElement({
    required bool Function(T element) find,
    required T element,
    T Function()? orElse,
    bool shouldThrowError = false,
  }) {
    try {
      final T current = firstWhere(find, orElse: orElse);
      final int index = indexOf(current);
      removeAt(index);
      insert(index, element);
    } catch (ex) {
      Logger.logAsync(
        LogEvent<List<T>>(
          severity: Severity.error,
          tag: Tag.extension,
          line: ex.toString(),
        ),
      );
      if (shouldThrowError) rethrow;
    }
  }
}
