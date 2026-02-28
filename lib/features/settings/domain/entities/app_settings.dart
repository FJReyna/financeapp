import 'package:flutter/material.dart';

class AppSettings {
  final ThemeMode themeMode;
  final String currency;
  final String locale;
  final bool pinEnabled;
  final String? pinHash;

  AppSettings({
    required this.themeMode,
    required this.currency,
    required this.locale,
    this.pinEnabled = false,
    this.pinHash,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? currency,
    String? locale,
    bool? pinEnabled,
    String? pinHash,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      currency: currency ?? this.currency,
      locale: locale ?? this.locale,
      pinEnabled: pinEnabled ?? this.pinEnabled,
      pinHash: pinHash ?? this.pinHash,
    );
  }
}
