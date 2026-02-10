import 'package:finance/features/settings/data/model/app_settings_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class SettingsLocalDatasource {
  final Box<AppSettingsModel> settingsBox;

  SettingsLocalDatasource(this.settingsBox);

  Future<void> saveSettings(AppSettingsModel settings) async {
    await settingsBox.put('app_settings', settings);
  }

  Future<AppSettingsModel?> getSettings() async {
    return settingsBox.get('app_settings');
  }
}
