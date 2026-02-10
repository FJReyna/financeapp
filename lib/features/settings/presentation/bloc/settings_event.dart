import 'package:finance/features/settings/domain/entities/app_settings.dart';
import 'package:flutter/material.dart';

abstract class SettingsEvent {}

class GetSettingsEvent extends SettingsEvent {}

class SaveSettingsEvent extends SettingsEvent {
  final AppSettings settings;

  SaveSettingsEvent(this.settings);
}

class ChangeThemeEvent extends SettingsEvent {
  final ThemeMode themeMode;
  ChangeThemeEvent(this.themeMode);
}

class ChangeCurrencyEvent extends SettingsEvent {
  final String currency;
  ChangeCurrencyEvent(this.currency);
}
