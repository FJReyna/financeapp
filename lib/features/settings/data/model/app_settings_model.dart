import 'package:finance/core/database/hive_type_id.dart';
import 'package:finance/features/settings/domain/entities/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'app_settings_model.g.dart';

@HiveType(typeId: HiveTypeId.appSettings)
class AppSettingsModel {
  @HiveField(0)
  final int themeMode;

  @HiveField(1)
  final String currency;

  @HiveField(2)
  final String locale;

  @HiveField(3)
  final bool pinEnabled;

  @HiveField(4)
  final String? pinHash;

  AppSettingsModel({
    required this.themeMode,
    required this.currency,
    required this.locale,
    this.pinEnabled = false,
    this.pinHash,
  });

  factory AppSettingsModel.fromEntity(AppSettings settings) {
    return AppSettingsModel(
      themeMode: settings.themeMode.index,
      currency: settings.currency,
      locale: settings.locale,
      pinEnabled: settings.pinEnabled,
      pinHash: settings.pinHash,
    );
  }

  AppSettings toEntity() {
    return AppSettings(
      themeMode: ThemeMode.values[themeMode],
      currency: currency,
      locale: locale,
      pinEnabled: pinEnabled,
      pinHash: pinHash,
    );
  }
}
