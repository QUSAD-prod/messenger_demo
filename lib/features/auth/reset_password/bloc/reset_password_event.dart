part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent {}

class ResetPasswordSendEvent extends ResetPasswordEvent {
  ResetPasswordSendEvent({
    required this.email,
  });
  final String email;
}
