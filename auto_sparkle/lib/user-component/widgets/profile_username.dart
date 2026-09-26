import 'package:flutter/material.dart';
import 'package:auto_sparkle/common/constants.dart';

class ProfileUsernameWidget extends StatelessWidget {
  const ProfileUsernameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DemoUser.NAME,
              style: Theme.of(context).textTheme.titleLarge?.merge(
                    const TextStyle(
                      fontFamily: FontFamily.PRIMARY,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            const SizedBox(width: 5),
            const Icon(
              IconData(0xe699, fontFamily: 'MaterialIcons'),
              color: Colors.green,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Customer',
          style: Theme.of(context).textTheme.titleMedium?.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
        ),
      ],
    );
  }
}
