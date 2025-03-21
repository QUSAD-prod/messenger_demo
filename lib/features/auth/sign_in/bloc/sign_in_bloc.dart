import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/repository/app_firebase_auth.dart';
import 'package:messenger_demo/router/router.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInEmailPasswordEvent>((event, emit) {});
    on<SignInResetPasswordEvent>((event, emit) {});
    on<SignInGoogleEvent>(
      (event, emit) async => await AppFirebaseAuth.signInWithGoogle(
        onLoading: () => emit(SignInLoadingState()),
        onLoaded: () {
          emit(SignInLoadedState());
          GetIt.I<AppRouter>().pushAndPopUntil(
            AuthRedirectRoute(),
            predicate: (route) => false,
          );
        },
        onFailure: () => emit(SignInFailureState()),
      ),
    );
    on<SignInAppleEvent>((event, emit) {});
  }
}
