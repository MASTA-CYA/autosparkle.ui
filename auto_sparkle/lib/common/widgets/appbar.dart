import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/common/navigator/page_navigator.dart';
import 'package:auto_sparkle/common/widgets/scrolling_text.dart';
import 'package:flutter/material.dart';

class AppBarWidget<T> extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget? actions;

  const AppBarWidget({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  State<StatefulWidget> createState() => _AppBarWidget<T>();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidget<T> extends State<AppBarWidget<T>> {
  static const String _aboutOption = 'About';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(),
      leading: _buildBackButton(),
      title: _buildTitle(),
      elevation: 4,
      actions: [
        widget.actions ?? const SizedBox.shrink(),
        const SizedBox(width: 10),
        _buildApplicationButton(),
      ],
    );
  }

  Widget? _buildBackButton() {
    return ModalRoute.of(context)!.impliesAppBarDismissal &&
            !T.toString().contains('Page')
        ? BackButton(
            onPressed: () => PageNavigator.navigateBack<T>(context),
          )
        : null;
  }

  Widget _buildTitle() {
    TextStyle? style = Theme.of(context)
        .textTheme
        .headlineMedium
        ?.merge(Theme.of(context).appBarTheme.titleTextStyle);

    bool isSmallDevice =
        MediaQuery.of(context).size.width < DeviceSize.SMALL_DEVICE_WIDTH;
    bool isLargeText = widget.title.length > 16;
    if (isSmallDevice || isLargeText) {
      return SizedBox(
        height: kToolbarHeight,
        child: Center(
          child: ScrollingTextWidget(
            text: widget.title,
            textStyle: style,
          ),
        ),
      );
    } else {
      return Text(
        widget.title,
        style: style,
      );
    }
  }

  Widget _buildApplicationButton() {
    return PopupMenuButton<String>(
      elevation: 1,
      offset: const Offset(0, 58),
      tooltip: 'Appbar options',
      itemBuilder: (context) => _buildMenuOptions(context),
      onSelected: _onMenuOptionSelected,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(right: 6),
          child: Icon(
            Icons.more_vert,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildMenuOptions(BuildContext context) {
    return const <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: _aboutOption,
        child: Row(
          children: [
            ImageIcon(
              ResizeImage(
                AssetImage('assets/images/information.png'),
                width: 70,
                height: 70,
                allowUpscaling: false,
              ),
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text('About Us'),
          ],
        ),
      ),
    ];
  }

  void _onMenuOptionSelected(String option) {
    switch (option) {
      case _aboutOption:
        showAboutDialog(
          context: context,
          applicationName: 'Auto Sparkle',
          applicationVersion: '1.0.0',
          applicationIcon: Image.asset(
            'assets/images/launcher.png',
            width: 48,
            height: 48,
          ),
          children: const [
            Text(
              'Book a car wash at home or at our shop, keep track of your '
              'appointments and shop for car accessories.',
            ),
          ],
        );
        break;
    }
  }
}
