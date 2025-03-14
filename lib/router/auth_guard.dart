import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/router/router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    await GetIt.I<FirebaseAuth>().currentUser?.reload();

    if (GetIt.I<FirebaseAuth>().currentUser != null) {
      resolver.next(true);
    } else {
      router.push(const WelcomeRoute());
    }
  }
}
