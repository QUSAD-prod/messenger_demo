part of 'confirm_email_bloc.dart';

abstract class ConfirmEmailState {}

class ConfirmEmailInitialState extends ConfirmEmailState {}

class ConfirmEmailLoadingState extends ConfirmEmailState {}

class ConfirmEmailLoadedState extends ConfirmEmailState {
  ConfirmEmailLoadedState({
    required this.timestamp,
  });
  final DateTime timestamp;
}

class ConfirmEmailFailureState extends ConfirmEmailState {}
