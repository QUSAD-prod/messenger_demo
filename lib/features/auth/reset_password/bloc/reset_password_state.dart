part of 'reset_password_bloc.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitialState extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordLoadedState extends ResetPasswordState {}

class ResetPasswordFailureState extends ResetPasswordState {
  ResetPasswordFailureState({
    this.emailError,
    this.otherError,
  });

  String? emailError, otherError;
}
