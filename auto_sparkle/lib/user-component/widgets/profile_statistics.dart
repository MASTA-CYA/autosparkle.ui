import 'package:auto_sparkle/appointments-component/appointments_page.dart';
import 'package:auto_sparkle/common/navigator/page_navigator.dart';
import 'package:auto_sparkle/home-component/home_page.dart';
import 'package:flutter/material.dart';

class ProfileStatisticsWidget extends StatelessWidget {
  const ProfileStatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildButton(
          context,
          '2',
          'Washes',
          () => PageNavigator.navigateTo<AppointmentsPage>(
            context,
            const AppointmentsPage(),
            useScheduler: false,
          ),
        ),
        _buildDivider(),
        _buildButton(
          context,
          '541',
          'Points',
          () => PageNavigator.navigateTo<HomePage>(
            context,
            const HomePage(),
            useScheduler: false,
          ),
        ),
        _buildDivider(),
        _buildButton(
          context,
          '5',
          'Reviews',
          () => PageNavigator.navigateTo<AppointmentsPage>(
            context,
            const AppointmentsPage(),
            useScheduler: false,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 30,
      child: const VerticalDivider(),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String value,
    String text,
    VoidCallback onPressed,
  ) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
