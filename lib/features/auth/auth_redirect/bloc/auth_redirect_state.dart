part of 'auth_redirect_bloc.dart';

abstract class AuthRedirectState {}

class AuthRedirectInitialState extends AuthRedirectState {}

class AuthRedirectLoadingState extends AuthRedirectState {}

class AuthRedirectLoadedState extends AuthRedirectState {}
