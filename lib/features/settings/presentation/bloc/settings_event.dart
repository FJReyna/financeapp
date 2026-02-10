import 'package:finance/features/settings/domain/entities/app_settings.dart';

abstract class SettingsEvent {}

class GetSettingsEvent extends SettingsEvent {}

class SaveSettingsEvent extends SettingsEvent {
  final AppSettings settings;

  SaveSettingsEvent(this.settings);
}
