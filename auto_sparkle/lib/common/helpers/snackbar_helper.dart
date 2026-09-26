import 'package:flutter/material.dart';

class SnackbarHelper {
  /// Shows a short message at the bottom of the current screen.
  static void show(
    BuildContext context,
    String message, {
    IconData icon = Icons.info_outline,
  }) {
    if (!context.mounted || message.isEmpty) return;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
  }

  /// Placeholder feedback for features that need a backend or aren't built yet.
  static void showComingSoon(BuildContext context, String feature) {
    show(context, '$feature is coming soon', icon: Icons.construction);
  }
}
