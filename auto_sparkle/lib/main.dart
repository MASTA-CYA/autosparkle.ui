import 'package:auto_sparkle/common/navigator/logging_page_route_observer.dart';
import 'package:auto_sparkle/common/navigator/page_route_helper.dart';
import 'package:auto_sparkle/common/themes/themes.dart';
import 'package:auto_sparkle/message-component/services/message_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  runApp(const Main());
}

class Main extends StatelessWidget {
  final String title = 'Auto Sparkle';
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => MessageService(),
        ),
      ],
      child: MaterialApp(
        restorationScopeId: 'app',
        navigatorKey: navigatorKey,
        title: title,
        theme: AppThemes.lightTheme,
        themeAnimationCurve: Curves.easeIn,
        debugShowCheckedModeBanner: false,
        onGenerateInitialRoutes: (initialRoute) =>
            PageRouteHelper.onGenerateInitialRoutes(
          context,
          initialRoute,
        ),
        onGenerateRoute: (settings) => PageRouteHelper.onGenerateRoute(
          context,
          settings,
        ),
        onUnknownRoute: (settings) => PageRouteHelper.onUnknownRoute(
          context,
          settings,
        ),
        navigatorObservers: [LoggingPageRouteObserver()],
      ),
    );
  }
}
