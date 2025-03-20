import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/repository/app_firebase_auth.dart';
import 'package:messenger_demo/router/router.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitialState()) {
    on<WelcomeAnonymusAuthEvent>(
      (event, emit) async {
        await AppFirebaseAuth.signInAnonymously(
          onLoading: () => emit(WelcomeLoadingState()),
          onLoaded: () {
            emit(WelcomeLoadedState());
            GetIt.I<AppRouter>().pushAndPopUntil(
              AuthRedirectRoute(),
              predicate: (route) => false,
            );
          },
          onFailure: () => emit(WelcomeFailureState()),
        );
      },
    );
  }
}
