import 'dart:convert';

import 'package:auto_sparkle/common/logger/enums/severity_enum.dart';
import 'package:auto_sparkle/common/logger/enums/tag_enum.dart';
import 'package:auto_sparkle/common/logger/logger.dart';
import 'package:auto_sparkle/common/logger/models/log_event_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences? _preferences;

  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() => _instance;

  SharedPreferencesService._internal();

  Future<void> _initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<String> readAsync(String key) async {
    if (_preferences == null) {
      await _initPreferences();
    }

    try {
      if (_preferences!.containsKey(key)) {
        return json.decode(_preferences!.getString(key) ?? '');
      } else {
        throw Exception('Key not found: $key');
      }
    } on Exception catch (e) {
      await _logErrorAsync(e, 'Unable to retrieve data for key: $key');
      rethrow;
    }
  }

  Future<void> saveAsync(String key, dynamic value) async {
    if (_preferences == null) {
      await _initPreferences();
    }

    try {
      await _preferences!.setString(key, json.encode(value));
    } on Exception catch (e) {
      await _logErrorAsync(e, 'Unable to save data for key: $key');
      rethrow;
    }
  }

  Future<void> _logErrorAsync(Exception e, String message) async {
    await Logger.logAsync(
      LogEvent<SharedPreferencesService>(
        severity: Severity.error,
        tag: Tag.service,
        line: '$message. $e',
      ),
    );
  }
}
