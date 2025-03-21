part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpLoadedState extends SignUpState {}

class SignUpFailureState extends SignUpState {}
