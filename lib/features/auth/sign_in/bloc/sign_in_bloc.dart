import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInEmailPasswordEvent>((event, emit) {});
    on<SignInResetPasswordEvent>((event, emit) {});
    on<SignInGoogleEvent>((event, emit) {});
    on<SignInAppleEvent>((event, emit) {});
  }
}
