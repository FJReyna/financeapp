import 'package:finance/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension Translate on BuildContext {
  AppLocalizations get translate => AppLocalizations.of(this)!;
}

extension Language on Locale {
  String get languageName {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      default:
        return languageCode;
    }
  }
}
