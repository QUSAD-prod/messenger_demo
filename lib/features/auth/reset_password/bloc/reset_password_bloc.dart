import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/repository/authentication_repository.dart';
import 'package:messenger_demo/router/app_router.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitialState()) {
    on<ResetPasswordSendEvent>(
      (event, emit) async => await AuthenticationRepository.sendResetPasswordEmail(
        email: event.email,
        onLoading: () => emit(ResetPasswordLoadingState()),
        onLoaded: () {
          emit(ResetPasswordLoadedState());
          GetIt.I<AppRouter>().pop();
        },
        onFailure: ({String? emailError, String? passwordError, String? otherError}) => emit(
          ResetPasswordFailureState(
            emailError: emailError,
            otherError: otherError,
          ),
        ),
      ),
    );
  }
}
