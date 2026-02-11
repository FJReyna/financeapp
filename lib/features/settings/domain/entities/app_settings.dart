import 'package:flutter/material.dart';

class AppSettings {
  final ThemeMode themeMode;
  final String currency;
  final String locale;

  AppSettings({
    required this.themeMode,
    required this.currency,
    required this.locale,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? currency,
    String? locale,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      currency: currency ?? this.currency,
      locale: locale ?? this.locale,
    );
  }
}
