import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_demo/repository/app_firebase_auth.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitialState()) {
    on<WelcomeAnonymusAuthEvent>(
      (event, emit) async {
        AppFirebaseAuth.signInAnonymously(
          onLoading: () => emit(WelcomeLoadingState()),
          onLoaded: () => {},
          onFailure: () => emit(WelcomeFailureState()),
        );
      },
    );
  }
}
