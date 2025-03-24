part of 'sign_in_bloc.dart';

abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInLoadedState extends SignInState {}

class SignInFailureState extends SignInState {
  SignInFailureState({
    this.emailError,
    this.passwordError,
    this.otherError,
  });

  String? emailError, passwordError, otherError;
}
