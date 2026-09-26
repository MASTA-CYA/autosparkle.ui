import 'package:auto_sparkle/common/helpers/snackbar_helper.dart';
import 'package:auto_sparkle/common/logger/enums/severity_enum.dart';
import 'package:auto_sparkle/common/logger/enums/tag_enum.dart';
import 'package:auto_sparkle/common/logger/logger.dart';
import 'package:auto_sparkle/common/logger/models/log_event_model.dart';
import 'package:auto_sparkle/message-component/models/message_severity_enum.dart';
import 'package:auto_sparkle/message-component/services/message_service.dart';
import 'package:flutter/material.dart';

/// Collects a short bug description. Reports are written to the app log and
/// acknowledged in Messages until a backend exists to send them to.
class ReportBugDialog extends StatefulWidget {
  const ReportBugDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => const ReportBugDialog(),
    );
  }

  @override
  State<ReportBugDialog> createState() => _ReportBugDialogState();
}

class _ReportBugDialogState extends State<ReportBugDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Report a bug'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLines: 4,
        textInputAction: TextInputAction.newline,
        decoration: const InputDecoration(
          hintText: 'What went wrong?',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _onSubmitPressed,
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Future<void> _onSubmitPressed() async {
    final String description = _controller.text.trim();
    if (description.isEmpty) return;

    await Logger.logAsync(
      LogEvent<ReportBugDialog>(
        severity: Severity.error,
        tag: Tag.application,
        line: 'Bug report: $description',
      ),
    );
    await MessageService().saveMessageAsync(
      'Bug report received',
      'Thanks for letting us know. Your report was saved: "$description"',
      MessageSeverity.information,
    );

    if (!mounted) return;
    SnackbarHelper.show(
      context,
      'Thanks! Your bug report was saved.',
      icon: Icons.check_circle_outline,
    );
    Navigator.of(context).pop();
  }
}
