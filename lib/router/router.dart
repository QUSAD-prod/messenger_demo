import 'package:auto_route/auto_route.dart';
import 'package:messenger_demo/features/auth/auth_redirect/view/auth_redirect_screen.dart';
import 'package:messenger_demo/features/auth/confirm_email/view/confirm_email_screen.dart';
import 'package:messenger_demo/features/auth/sign_in/view/sign_in_screen.dart';
import 'package:messenger_demo/features/auth/sign_up/view/sign_up_screen.dart';
import 'package:messenger_demo/features/auth/welcome/view/welcome_screen.dart';
import 'package:messenger_demo/features/home/view/home_screen.dart';
import 'package:messenger_demo/features/logs/view/logs_screen.dart';
import 'package:messenger_demo/features/settings/view/settings_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen|Page,Route',
)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AuthRedirectRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: WelcomeRoute.page,
        ),
        AutoRoute(
          page: SignInRoute.page,
        ),
        AutoRoute(
          page: SignUpRoute.page,
        ),
        AutoRoute(
          page: ConfirmEmailRoute.page,
        ),
        AutoRoute(
          page: HomeRoute.page,
        ),
        AutoRoute(
          page: SettingsRoute.page,
        ),
        AutoRoute(
          page: LogsRoute.page,
        ),
      ];
}
