part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class SignInEmailPasswordEvent extends SignInEvent {}

class SignInResetPasswordEvent extends SignInEvent {}

class SignInGoogleEvent extends SignInEvent {}

class SignInAppleEvent extends SignInEvent {}
