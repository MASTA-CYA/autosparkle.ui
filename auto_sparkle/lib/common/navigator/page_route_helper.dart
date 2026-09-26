import 'package:auto_sparkle/appointments-component/appointments_page.dart';
import 'package:auto_sparkle/appointments-component/widgets/appointment.dart';
import 'package:auto_sparkle/home-component/home_page.dart';
import 'package:auto_sparkle/message-component/messages_page.dart';
import 'package:auto_sparkle/shop-component/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:auto_sparkle/common/extensions.dart';
import 'package:auto_sparkle/common/navigator/named_page_route_model.dart';
import 'package:auto_sparkle/common/navigator/page_route.dart';
import 'package:auto_sparkle/common/navigator/transition_direction_enum.dart';
import 'package:auto_sparkle/common/navigator/unknown_route.dart';
import 'package:auto_sparkle/user-component/user_profile_page.dart';

class PageRouteHelper {
  static Widget getInitialRouteWidget() {
    return _getPageRoutes().first.widget;
  }

  static String getInitialRoutePath() {
    return _getPageRoutes().first.path;
  }

  /// Every page reachable through [PageNavigator] must be registered here.
  /// The first entry is the app's initial route.
  static List<NamedPageRoute> _getPageRoutes() {
    return [
      const NamedPageRoute(
        name: 'HomePage',
        widget: HomePage(),
      ),
      const NamedPageRoute(
        name: 'AppointmentsPage',
        widget: AppointmentsPage(),
      ),
      const NamedPageRoute(
        name: 'AppointmentWidget',
        widget: AppointmentWidget(),
      ),
      const NamedPageRoute(
        name: 'ShopPage',
        widget: ShopPage(),
      ),
      const NamedPageRoute(
        name: 'MessagesPage',
        widget: MessagesPage(),
      ),
      const NamedPageRoute(
        name: 'UserProfilePage',
        widget: UserProfilePage(),
      ),
    ];
  }

  static Route<dynamic>? onGenerateRoute(
    BuildContext context,
    RouteSettings settings,
  ) {
    if (settings.name?.equals('/') ?? false) {
      return AnimatedMaterialPageRoute(
        widget: getInitialRouteWidget(),
        transitionColor: Theme.of(context).scaffoldBackgroundColor,
        settings: RouteSettings(name: getInitialRoutePath()),
      );
    } else if (!settings.name.isNull) {
      NamedPageRoute page = _getPageRoutes().firstWhere(
          (route) => route.path.equals(settings.name ?? ''),
          orElse: () => _getPageRoutes().first);
      return AnimatedMaterialPageRoute(
        widget: page.widget,
        transitionColor: Theme.of(context).scaffoldBackgroundColor,
        settings: RouteSettings(name: page.path),
      );
    } else {
      return null;
    }
  }

  static List<Route<dynamic>> onGenerateInitialRoutes(
    BuildContext context,
    String initialRoute,
  ) {
    final NamedPageRoute initial = _getPageRoutes().first;

    return [
      AnimatedMaterialPageRoute(
        widget: initial.widget,
        transitionColor: Theme.of(context).scaffoldBackgroundColor,
        settings: RouteSettings(name: initial.path),
      ),
    ];
  }

  static Route<dynamic>? onUnknownRoute(
      BuildContext context, RouteSettings settings) {
    return AnimatedMaterialPageRoute(
      widget: const UnknownRouteWidget(),
      transitionColor: Theme.of(context).scaffoldBackgroundColor,
      settings: settings,
    );
  }

  static Route<void> generateRestorableRoute(
    BuildContext context,
    Map<Object?, Object?> params,
  ) {
    Widget widget = _getPageRoutes()
        .firstWhere(
          (route) => route.name.equals(params['name'] as String),
          orElse: () => _getPageRoutes().first,
        )
        .widget;
    return AnimatedMaterialPageRoute(
      widget: widget,
      transitionColor: Theme.of(context).scaffoldBackgroundColor,
      direction: TransitionDirection.fromName(params['direction'] as String),
      settings: RouteSettings(name: '/${params['name']}'),
    );
  }
}
