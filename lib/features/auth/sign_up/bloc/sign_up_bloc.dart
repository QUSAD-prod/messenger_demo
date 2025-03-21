import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/repository/app_firebase_auth.dart';
import 'package:messenger_demo/router/router.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpEmailPasswordEvent>((event, emit) {});
    on<SignUpGoogleEvent>(
      (event, emit) async => await AppFirebaseAuth.signInWithGoogle(
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
