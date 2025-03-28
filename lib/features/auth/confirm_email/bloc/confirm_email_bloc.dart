import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/repository/authentication_repository.dart';
import 'package:messenger_demo/router/router.dart';

part 'confirm_email_event.dart';
part 'confirm_email_state.dart';

class ConfirmEmailBloc extends Bloc<ConfirmEmailEvent, ConfirmEmailState> {
  ConfirmEmailBloc() : super(ConfirmEmailInitialState()) {
    on<CheckConfirmEmailEvent>(
      (event, emit) async => await AuthenticationRepository.checkEmailVerifyStatus(
        onVerified: () => GetIt.I<AppRouter>().pushAndPopUntil(
          AuthRedirectRoute(),
          predicate: (route) => false,
        ),
      ),
    );

    on<SendConfirmEmailEvent>(
      (event, emit) async => await AuthenticationRepository.sendVerificationEmail(
        onLoading: () => emit(ConfirmEmailLoadingState()),
        onLoaded: () {
          emit(ConfirmEmailLoadedState(timestamp: DateTime.now().add(Duration(seconds: 60))));
        },
        onFailure: () => emit(ConfirmEmailFailureState()),
      ),
    );
  }
}
