part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class SignInEmailPasswordEvent extends SignInEvent {
  SignInEmailPasswordEvent({
    required this.email,
    required this.password,
  });
  final String email, password;
}

class SignInResetPasswordEvent extends SignInEvent {}

class SignInGoogleEvent extends SignInEvent {}

class SignInAppleEvent extends SignInEvent {}
