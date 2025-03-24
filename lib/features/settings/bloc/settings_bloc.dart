import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/repository/authentication_repository.dart';
import 'package:messenger_demo/router/router.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitialState()) {
    on<SettingsSignOutEvent>(
      (event, emit) async => await AuthenticationRepository.signOut(
        onLoading: () => emit(SettingsLoadingState()),
        onLoaded: () {
          emit(SettingsLoadedState());
          GetIt.I<AppRouter>().pushAndPopUntil(
            AuthRedirectRoute(),
            predicate: (route) => false,
          );
        },
        onFailure: () => emit(SettingsFailureState()),
      ),
    );
  }
}
