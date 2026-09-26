import 'package:auto_sparkle/common/logger/models/log_event_model.dart';
import 'package:auto_sparkle/common/services/file_storage_service.dart';
import 'package:flutter/foundation.dart';

class Logger {
  static Future<void> logAsync(LogEvent event) async {
    if (!kReleaseMode) debugPrint(event.toString());

    await FileStorageService.writeStringAsync<Logger>(event.toString());
  }
}
