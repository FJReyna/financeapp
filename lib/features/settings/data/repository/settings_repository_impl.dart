import 'package:finance/features/settings/data/datasource/local/settings_local_datasource.dart';
import 'package:finance/features/settings/data/model/app_settings_model.dart';
import 'package:finance/features/settings/domain/entities/app_settings.dart';
import 'package:finance/features/settings/domain/repository/settings_repository.dart';
import 'package:flutter/material.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDatasource _localDatasource;

  SettingsRepositoryImpl(this._localDatasource);

  @override
  Future<void> saveSettings(AppSettings settings) async {
    await _localDatasource.saveSettings(AppSettingsModel.fromEntity(settings));
  }

  @override
  Future<AppSettings> getSettings() async {
    final model = await _localDatasource.getSettings();

    if (model != null) {
      return model.toEntity();
    } else {
      return AppSettings(
        themeMode: ThemeMode.system,
        currency: 'USD',
        locale: 'en',
      );
    }
  }
}
