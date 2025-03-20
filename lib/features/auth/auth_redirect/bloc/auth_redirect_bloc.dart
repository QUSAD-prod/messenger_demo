import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/repository/app_firebase_auth.dart';
import 'package:messenger_demo/router/router.dart';

part 'auth_redirect_event.dart';
part 'auth_redirect_state.dart';

class AuthRedirectBloc extends Bloc<AuthRedirectEvent, AuthRedirectState> {
  AuthRedirectBloc() : super(AuthRedirectInitialState()) {
    on<AuthRedirectCheckEvent>(
      (event, emit) {
        AppFirebaseAuth.checkAuthStatus(
          onLoading: () => emit(AuthRedirectLoadingState()),
          onSignedIn: () {
            emit(AuthRedirectLoadedState());
            GetIt.I<AppRouter>().pushAndPopUntil(
              HomeRoute(),
              predicate: (route) => false,
            );
          },
          onNotSignedIn: () {
            emit(AuthRedirectLoadedState());
            GetIt.I<AppRouter>().pushAndPopUntil(
              WelcomeRoute(),
              predicate: (route) => false,
            );
          },
        );
      },
    );
  }
}
