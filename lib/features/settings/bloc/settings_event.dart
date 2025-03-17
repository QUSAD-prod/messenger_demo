part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class SettingsInitEvent extends SettingsEvent {}

class SettingsChangeThemeEvent extends SettingsEvent {}

class SettingsChangeLocalizationEvent extends SettingsEvent {}

class SettingsSignOutEvent extends SettingsEvent {}

class SettingsDeleteAccountEvent extends SettingsEvent {}
