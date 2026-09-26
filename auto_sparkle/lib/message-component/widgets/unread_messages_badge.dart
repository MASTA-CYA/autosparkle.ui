import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/message-component/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Wraps [child] in a badge showing the number of unread messages.
/// The badge is hidden when there are no unread messages.
class UnreadMessagesBadge extends StatelessWidget {
  final Widget child;

  const UnreadMessagesBadge({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageService>(
      builder: (context, service, _) => FutureBuilder<int>(
        future: service.getUnreadMessageCountAsync(),
        builder: (context, snapshot) {
          final int count = snapshot.data ?? 0;
          return Badge(
            isLabelVisible: count > 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: Text(
              '$count',
              style: Theme.of(context).textTheme.labelSmall?.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontFamily: FontFamily.PRIMARY,
                    ),
                  ),
            ),
            child: child,
          );
        },
      ),
    );
  }
}
