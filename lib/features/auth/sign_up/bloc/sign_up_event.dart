part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpEmailPasswordEvent extends SignUpEvent {
  SignUpEmailPasswordEvent({
    required this.email,
    required this.password,
  });
  final String email, password;
}

class SignUpGoogleEvent extends SignUpEvent {}

class SignUpAppleEvent extends SignUpEvent {}
