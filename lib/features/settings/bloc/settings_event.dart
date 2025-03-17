part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class SettingsChangeThemeEvent extends SettingsEvent {}

class SettingsChangeLocalizationEvent extends SettingsEvent {}

class SettingsSignOutEvent extends SettingsEvent {}
