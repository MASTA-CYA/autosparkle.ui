import 'dart:convert';
import 'dart:io';

import 'package:auto_sparkle/common/extensions.dart';
import 'package:auto_sparkle/common/logger/enums/severity_enum.dart';
import 'package:auto_sparkle/common/logger/enums/tag_enum.dart';
import 'package:auto_sparkle/common/logger/logger.dart';
import 'package:auto_sparkle/common/logger/models/log_event_model.dart';
import 'package:flutter/scheduler.dart';
import 'package:path_provider/path_provider.dart';

class FileStorageService {
  static Directory? _appSupDirectory;
  static Directory? _appTempDirectory;

  static Future<File> getFileInstanceAsync<T>({String? key}) async {
    if (_appSupDirectory.isNull) {
      _appSupDirectory = await getApplicationSupportDirectory();
    }
    if (_appTempDirectory.isNull) {
      _appTempDirectory = await getApplicationCacheDirectory();
    }

    // Logs live in app support; everything else is cache that can be rebuilt.
    if (T == Logger) {
      return File('${_appSupDirectory!.path}/logs.log');
    }

    return File('${_appTempDirectory!.path}/${key ?? T}.json');
  }

  static Future<void> writeStringAsync<T>(
    String contents, {
    Encoding encoding = utf8,
    FileMode mode = FileMode.writeOnlyAppend,
    String? key,
  }) async {
    try {
      (await getFileInstanceAsync<T>(key: key)).writeAsStringSync(
        contents,
        encoding: encoding,
        mode: mode,
        flush: true,
      );
    } on Exception catch (ex) {
      _writeToLogFile(ex.toString());
    }
  }

  static Future<String?> readAsync<T>({String? key}) async {
    String? contents;

    try {
      contents = await (await getFileInstanceAsync<T>(key: key)).readAsString();
    } on Exception catch (ex) {
      _writeToLogFile(ex.toString());
    }

    return contents;
  }

  static void _writeToLogFile(String line) {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        Logger.logAsync(
          LogEvent<FileStorageService>(
            severity: Severity.information,
            tag: Tag.service,
            line: line,
          ),
        );
      },
    );
  }
}
