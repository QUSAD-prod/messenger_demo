part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpEmailPasswordEvent extends SignUpEvent {}

class SignUpGoogleEvent extends SignUpEvent {}

class SignUpAppleEvent extends SignUpEvent {}
