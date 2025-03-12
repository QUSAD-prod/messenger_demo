import 'package:auto_route/auto_route.dart';
import 'package:messenger_demo/features/auth/view/auth_screen.dart';
import 'package:messenger_demo/features/home/view/home_screen.dart';
import 'package:messenger_demo/features/settings/view/settings_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/'),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}
