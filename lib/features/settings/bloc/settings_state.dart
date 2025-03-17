part of 'settings_bloc.dart';

abstract class SettingsState {}

class SettingsInitialState extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsLoadedState extends SettingsState {}

class SettingsFailureState extends SettingsState {}
