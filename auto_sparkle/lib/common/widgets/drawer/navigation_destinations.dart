import 'package:auto_sparkle/appointments-component/appointments_page.dart';
import 'package:auto_sparkle/home-component/home_page.dart';
import 'package:auto_sparkle/message-component/messages_page.dart';
import 'package:auto_sparkle/message-component/widgets/unread_messages_badge.dart';
import 'package:auto_sparkle/shop-component/shop_page.dart';
import 'package:auto_sparkle/user-component/user_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_sparkle/common/extensions.dart';
import 'package:auto_sparkle/common/helpers/color_helper.dart';
import 'package:auto_sparkle/common/navigator/page_navigator.dart';
import 'package:auto_sparkle/common/widgets/report_bug_dialog.dart';

/// Drawer entries. [T] is the page currently shown, which is highlighted.
class NavigationDestinationsWidget<T> extends StatelessWidget {
  const NavigationDestinationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDestination<HomePage>(
          context,
          title: 'Home',
          icon: (color) => _assetIcon('assets/images/home.png', color),
          page: const HomePage(),
        ),
        _buildDestination<AppointmentsPage>(
          context,
          title: 'Appointments',
          icon: (color) => _assetIcon('assets/images/appointment.png', color),
          page: const AppointmentsPage(),
        ),
        _buildDestination<ShopPage>(
          context,
          title: 'Shop',
          icon: (color) => _assetIcon('assets/images/shop.png', color),
          page: const ShopPage(),
        ),
        _buildDestination<MessagesPage>(
          context,
          title: 'Messages',
          icon: (color) => UnreadMessagesBadge(
            child: _assetIcon('assets/images/message.png', color),
          ),
          page: const MessagesPage(),
        ),
        _buildDestination<UserProfilePage>(
          context,
          title: 'Profile',
          icon: (color) => Icon(CupertinoIcons.profile_circled, color: color),
          page: const UserProfilePage(),
        ),
        _buildReportBug(context),
      ],
    );
  }

  Widget _buildDestination<P>(
    BuildContext context, {
    required String title,
    required Widget Function(Color? color) icon,
    required Widget page,
  }) {
    final bool isSelected = T.equals(P);
    final Color primary = Theme.of(context).colorScheme.primary;

    return ListTile(
      tileColor: isSelected ? ColorHelper.lighten(primary, 80) : null,
      leading: icon(isSelected ? primary : null),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.merge(
              TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? primary : null,
              ),
            ),
      ),
      onTap: () => PageNavigator.navigateTo<P>(
        context,
        page,
        shouldPop: true,
      ),
    );
  }

  Widget _buildReportBug(BuildContext context) {
    return ListTile(
      leading: _assetIcon('assets/images/bug.png', null),
      title: Text(
        'Report Bug',
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.merge(const TextStyle(fontWeight: FontWeight.bold)),
      ),
      onTap: () => ReportBugDialog.show(context),
    );
  }

  static Widget _assetIcon(String asset, Color? color) {
    return ImageIcon(
      ResizeImage(
        AssetImage(asset),
        width: 70,
        height: 70,
        allowUpscaling: false,
      ),
      color: color,
    );
  }
}
