import 'package:auto_sparkle/common/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:auto_sparkle/common/widgets/drawer/drawer_header.dart';
import 'package:auto_sparkle/common/widgets/drawer/navigation_destinations.dart';

class CustomNavigationDrawer<T> extends StatelessWidget {
  const CustomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLongList = MediaQuery.of(context).size.height >= 685;

    return SafeArea(
      child: Drawer(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const DrawerHeaderWidget(),
                  NavigationDestinationsWidget<T>(),
                  if (isLongList) _buildSignOutTile(context),
                ],
              ),
            ),
            if (!isLongList) _buildSignOutTile(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSignOutTile(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ListTile(
        leading: const Icon(
          Icons.exit_to_app,
        ),
        title: Text(
          'Sign Out',
          style: Theme.of(context).textTheme.titleMedium?.merge(
                const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        onTap: () => SnackbarHelper.showComingSoon(context, 'Signing in and out'),
      ),
    );
  }
}
