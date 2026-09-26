import 'package:auto_sparkle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Home page renders its main sections', (tester) async {
    await tester.pumpWidget(const Main());
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Auto Sparkle'), findsOneWidget);
    expect(find.text('Recurring Appointments'), findsWidgets);
    expect(find.text('Recent Transactions'), findsOneWidget);
  });

  testWidgets('Navigation drawer links to every main page', (tester) async {
    await tester.pumpWidget(const Main());
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pump(const Duration(seconds: 1));

    final Finder drawer = find.byType(Drawer);
    for (final String destination in [
      'Home',
      'Appointments',
      'Shop',
      'Messages',
      'Profile',
      'Report Bug',
    ]) {
      expect(
        find.descendant(of: drawer, matching: find.text(destination)),
        findsOneWidget,
      );
    }
  });
}
