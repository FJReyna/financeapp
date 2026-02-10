import 'package:flutter/material.dart';

class AppSettings {
  final ThemeMode themeMode;
  final String currency;

  AppSettings({required this.themeMode, required this.currency});

  AppSettings copyWith({ThemeMode? themeMode, String? currency}) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      currency: currency ?? this.currency,
    );
  }
}
