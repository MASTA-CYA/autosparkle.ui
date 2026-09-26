import 'dart:io';

import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/common/extensions.dart';
import 'package:auto_sparkle/common/logger/enums/severity_enum.dart';
import 'package:auto_sparkle/common/logger/enums/tag_enum.dart';
import 'package:auto_sparkle/common/logger/logger.dart';
import 'package:auto_sparkle/common/logger/models/log_event_model.dart';
import 'package:auto_sparkle/common/models/persistable_service.dart';
import 'package:auto_sparkle/common/models/serializable_model.dart';
import 'package:auto_sparkle/common/services/file_storage_service.dart';
import 'package:auto_sparkle/common/services/shared_preferences_service.dart';
import 'package:auto_sparkle/message-component/models/message_model.dart';
import 'package:auto_sparkle/message-component/models/message_severity_enum.dart';
import 'package:flutter/material.dart';

/// In-app inbox. Messages are kept in shared preferences, with a copy in the
/// app cache directory as a fallback.
class MessageService with ChangeNotifier implements PersistableService {
  static const String _MESSAGES_KEY = 'MESSAGES_KEY';

  late SharedPreferencesService _preferences;
  late List<SerializableModel<Message>> _messages;

  static final MessageService _instance = MessageService._internal();

  factory MessageService() => _instance;

  MessageService._internal() {
    _init();
  }

  Future<void> _init() async {
    _preferences = SharedPreferencesService();
    _messages = [];

    try {
      _messages = Message.decode(
        await _preferences.readAsync(_MESSAGES_KEY),
      );
    } on Exception catch (ex) {
      // Fall back to the copy kept in file storage
      String? result = await FileStorageService.readAsync<MessageService>();
      if (!result.isNull) {
        _messages = Message.decode(result!);
      }

      await Logger.logAsync(
        LogEvent<MessageService>(
          severity: Severity.error,
          tag: Tag.service,
          line: ex.toString(),
        ),
      );
    }

    if (_messages.isEmpty) {
      await _seedDemoMessagesAsync();
    }

    notifyListeners();
  }

  /// Adds sample messages on first launch so the demo inbox isn't empty.
  /// They are saved like any other message, so dismissing them is permanent.
  Future<void> _seedDemoMessagesAsync() async {
    final DateTime now = DateTime.now();
    final String firstName = DemoUser.NAME.split(' ').first;

    _messages.addAll(<Message>[
      Message(
        id: 0,
        date: now.subtract(const Duration(days: 1)).toIso8601String(),
        title: 'Our shop has moved',
        body: 'Garage washes now take place at our new location: '
            '22 Foam Avenue, Soap Ville, Shine City (previously 148 Sparkle '
            'Road). Home washes are not affected, and any shop bookings you '
            'already have have been moved to the new address.',
        severity: MessageSeverity.alert,
      ),
      Message(
        id: 1,
        date: now.toIso8601String(),
        title: 'R100 loyalty bonus added',
        body: 'Thanks for being a loyal Auto Sparkle customer, $firstName! '
            "We've added R100 bonus credit to your wallet. It will be applied "
            'automatically to your next wash.',
        severity: MessageSeverity.information,
      ),
    ]);

    await saveChangesAsync<MessageService>();
  }

  Future<void> saveMessageAsync(
    String title,
    String body,
    MessageSeverity severity,
  ) async {
    _messages.add(
      Message(
        id: _getNextId(),
        date: DateTime.now().toIso8601String(),
        title: title,
        body: body,
        severity: severity,
      ),
    );
    await saveChangesAsync<MessageService>(shouldNotifyListeners: true);
  }

  /// Messages that have not been dismissed, newest first.
  Future<List<SerializableModel<Message>>> getMessagesAsync() async {
    List<SerializableModel<Message>> messages = _messages
        .where(
          (message) => !message.model.hasBeenDismissed,
        )
        .toList();
    messages.sort(
      ((a, b) =>
          DateTime.parse(b.model.date).compareTo(DateTime.parse(a.model.date))),
    );

    return messages;
  }

  Future<SerializableModel<Message>> getMessageAsync(int id) async {
    return _messages.firstWhere(
      (message) => message.model.id == id,
      orElse: () => _messages.first.model,
    );
  }

  Future<int> getUnreadMessageCountAsync() async {
    return _messages
        .where(
          (message) =>
              !message.model.hasBeenRead && !message.model.hasBeenDismissed,
        )
        .length;
  }

  Future<bool> getMessageReadStatus(int id) async {
    return (await getMessageAsync(id)).model.hasBeenRead;
  }

  Future<bool> getMessageReportStatus(int id) async {
    return (await getMessageAsync(id)).model.hasBeenReported;
  }

  Future<void> readMessageAsync(int id) async {
    _messages.modifyElement(
      find: (element) => element.model.id == id,
      property: 'hasBeenRead',
      value: true,
    );
    await saveChangesAsync<MessageService>(shouldNotifyListeners: true);
  }

  Future<void> readAllMessagesAsync() async {
    for (SerializableModel<Message> message in _messages
        .where((message) => !message.model.hasBeenRead)
        .toList()) {
      _messages.modifyElement(
        find: (element) => element.model.id == message.model.id,
        property: 'hasBeenRead',
        value: true,
      );
    }
    await saveChangesAsync<MessageService>(shouldNotifyListeners: true);
  }

  Future<void> reportMessageAsync(int id) async {
    _messages.modifyElement(
      find: (element) => element.model.id == id,
      property: 'hasBeenReported',
      value: true,
    );
    await saveChangesAsync<MessageService>(shouldNotifyListeners: true);
  }

  Future<void> dismissMessageAsync(int id) async {
    _messages.modifyElement(
      find: (element) => element.model.id == id,
      property: 'hasBeenDismissed',
      value: true,
    );
    await saveChangesAsync<MessageService>(shouldNotifyListeners: true);
  }

  Future<void> dismissAllMessagesAsync() async {
    for (SerializableModel<Message> message in _messages
        .where((message) => !message.model.hasBeenDismissed)
        .toList()) {
      _messages.modifyElement(
        find: (element) => element.model.id == message.model.id,
        property: 'hasBeenDismissed',
        value: true,
      );
    }
    await saveChangesAsync<MessageService>(shouldNotifyListeners: true);
  }

  @override
  Future<void> saveChangesAsync<T>({
    bool shouldNotifyListeners = false,
  }) async {
    await _saveToPreferences();
    await _saveToStorage();
    if (shouldNotifyListeners) notifyListeners();
  }

  Future<void> _saveToPreferences() async {
    try {
      await _preferences.saveAsync(_MESSAGES_KEY,
          Message.encode(_messages.map((e) => e.model).toList()));
    } on Exception catch (ex) {
      await Logger.logAsync(
        LogEvent<MessageService>(
          severity: Severity.error,
          tag: Tag.service,
          line: ex.toString(),
        ),
      );
    }
  }

  Future<void> _saveToStorage() async {
    await FileStorageService.writeStringAsync<MessageService>(
      Message.encode(_messages.map((e) => e.model).toList()),
      mode: FileMode.writeOnly,
    );
  }

  int _getNextId() => _messages.isNotEmpty ? _messages.last.model.id + 1 : 0;
}
