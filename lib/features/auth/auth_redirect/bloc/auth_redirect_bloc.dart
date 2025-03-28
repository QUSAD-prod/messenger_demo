import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/repository/authentication_repository.dart';
import 'package:messenger_demo/router/router.dart';

part 'auth_redirect_event.dart';
part 'auth_redirect_state.dart';

class AuthRedirectBloc extends Bloc<AuthRedirectEvent, AuthRedirectState> {
  AuthRedirectBloc() : super(AuthRedirectInitialState()) {
    on<AuthRedirectCheckEvent>(
      (event, emit) async {
        await AuthenticationRepository.checkAuthStatus(
          onLoading: () => emit(AuthRedirectLoadingState()),
          onLoaded: () => emit(AuthRedirectLoadedState()),
          onSignedIn: () => GetIt.I<AppRouter>().pushAndPopUntil(
            HomeRoute(),
            predicate: (route) => false,
          ),
          onNotSignedIn: () => GetIt.I<AppRouter>().pushAndPopUntil(
            WelcomeRoute(),
            predicate: (route) => false,
          ),
          onNotVerified: () => GetIt.I<AppRouter>().pushAndPopUntil(
            ConfirmEmailRoute(),
            predicate: (route) => false,
          ),
        );
      },
    );
  }
}
