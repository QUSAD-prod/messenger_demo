import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/repository/authentication_repository.dart';
import 'package:messenger_demo/router/app_router.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpEmailPasswordEvent>(
      (event, emit) async => AuthenticationRepository.signUpWithEmailAndPassword(
        email: event.email,
        password: event.password,
        onLoading: () => emit(SignUpLoadingState()),
        onLoaded: () {
          emit(SignUpLoadedState());
          GetIt.I<AppRouter>().pushAndPopUntil(
            AuthRedirectRoute(),
            predicate: (route) => false,
          );
        },
        onFailure: ({String? emailError, String? passwordError, String? otherError}) => emit(
          SignUpFailureState(
            emailError: emailError,
            passwordError: passwordError,
            otherError: otherError,
          ),
        ),
      ),
    );

    on<SignUpGoogleEvent>(
      (event, emit) async => await AuthenticationRepository.signInWithGoogle(
        onLoading: () => emit(SignUpLoadingState()),
        onLoaded: () {
          emit(SignUpLoadedState());
          GetIt.I<AppRouter>().pushAndPopUntil(
            AuthRedirectRoute(),
            predicate: (route) => false,
          );
        },
        onFailure: () => emit(SignUpFailureState()),
      ),
    );

    on<SignUpAppleEvent>((event, emit) {});
  }
}
