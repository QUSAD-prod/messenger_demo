part of 'welcome_bloc.dart';

abstract class WelcomeState {}

class WelcomeInitialState extends WelcomeState {}

class WelcomeLoadingState extends WelcomeState {}

class WelcomeLoadedState extends WelcomeState {}

class WelcomeFailureState extends WelcomeState {}
