import 'package:finance/features/settings/domain/entities/app_settings.dart';

abstract class SettingsRepository {
  Future<void> saveSettings(AppSettings settings);
  Future<AppSettings> getSettings();
}
