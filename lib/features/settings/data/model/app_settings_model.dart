import 'package:finance/core/database/hive_type_id.dart';
import 'package:finance/features/settings/domain/entities/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'app_settings_model.g.dart';

@HiveType(typeId: HiveTypeId.appSettings)
class AppSettingsModel {
  @HiveField(0)
  final ThemeMode themeMode;
  @HiveField(1)
  final String currency;

  AppSettingsModel({required this.themeMode, required this.currency});

  factory AppSettingsModel.fromEntity(AppSettings settings) {
    return AppSettingsModel(
      themeMode: settings.themeMode,
      currency: settings.currency,
    );
  }

  AppSettings toEntity() {
    return AppSettings(themeMode: themeMode, currency: currency);
  }
}
