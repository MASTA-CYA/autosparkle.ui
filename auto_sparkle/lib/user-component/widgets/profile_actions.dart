import 'package:auto_sparkle/common/helpers/snackbar_helper.dart';
import 'package:auto_sparkle/common/navigator/page_navigator.dart';
import 'package:auto_sparkle/message-component/messages_page.dart';
import 'package:auto_sparkle/message-component/widgets/unread_messages_badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileActionsWidget extends StatelessWidget {
  const ProfileActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAddressAction(context),
        _buildDivider(),
        _buildMessages(context),
        _buildDivider(),
        _buildSettingsAction(context),
      ],
    );
  }

  Widget _buildAddressAction(BuildContext context) {
    return ListTile(
      leading: const Icon(
        CupertinoIcons.map_pin_ellipse,
      ),
      title: Text(
        'Address',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
      ),
      onTap: () => SnackbarHelper.showComingSoon(context, 'Saved addresses'),
    );
  }

  Widget _buildMessages(BuildContext context) {
    return ListTile(
      leading: const UnreadMessagesBadge(
        child: ImageIcon(
          ResizeImage(
            AssetImage('assets/images/message.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
        ),
      ),
      title: Text(
        'Messages',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
      ),
      onTap: () => PageNavigator.navigateTo<MessagesPage>(
        context,
        const MessagesPage(),
        useScheduler: false,
      ),
    );
  }

  Widget _buildSettingsAction(BuildContext context) {
    return ListTile(
      leading: const ImageIcon(
        ResizeImage(
          AssetImage('assets/images/settings.png'),
          width: 70,
          height: 70,
          allowUpscaling: false,
        ),
      ),
      title: Text(
        'Settings',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
      ),
      onTap: () => SnackbarHelper.showComingSoon(context, 'Settings'),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}
