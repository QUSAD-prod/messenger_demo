import 'package:auto_route/auto_route.dart';
import 'package:messenger_demo/features/auth/welcome/view/welcome_screen.dart';
import 'package:messenger_demo/features/home/view/home_screen.dart';
import 'package:messenger_demo/features/logs/view/logs_screen.dart';
import 'package:messenger_demo/features/settings/view/settings_screen.dart';
import 'package:messenger_demo/router/auth_guard.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        page: HomeRoute.page,
        path: '/',
        guards: [
          AuthGuard(),
        ],
      ),
      AutoRoute(
        page: WelcomeRoute.page,
      ),
      AutoRoute(
        page: SettingsRoute.page,
        guards: [
          AuthGuard(),
        ],
      ),
      AutoRoute(
        page: LogsRoute.page,
        guards: [
          AuthGuard(),
        ],
      ),
    ];
  }
}
