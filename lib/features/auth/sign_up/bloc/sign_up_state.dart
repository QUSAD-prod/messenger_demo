// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpLoadedState extends SignUpState {}

class SignUpFailureState extends SignUpState {
  SignUpFailureState({
    this.emailError,
    this.passwordError,
    this.otherError,
  });

  String? emailError, passwordError, otherError;
}
