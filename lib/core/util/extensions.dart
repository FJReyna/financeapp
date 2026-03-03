import 'package:finance/features/category/domain/entites/category.dart';
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
  Locale get locale => Localizations.localeOf(this);
}

extension Localize on ThemeMode {
  String localize(BuildContext context) {
    switch (this) {
      case ThemeMode.system:
        return context.translate.settingsThemeSystem;
      case ThemeMode.light:
        return context.translate.settingsThemeLight;
      case ThemeMode.dark:
        return context.translate.settingsThemeDark;
    }
  }
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

extension CategoryNameExtension on Category {
  String localizedName(BuildContext context) {
    if (nameKey == null) {
      return name;
    }

    final localizations = AppLocalizations.of(context)!;
    switch (nameKey) {
      case 'housingCategory':
        return localizations.housingCategory;
      case 'foodCategory':
        return localizations.foodCategory;
      case 'transportationCategory':
        return localizations.transportationCategory;
      case 'entertainmentCategory':
        return localizations.entertainmentCategory;
      case 'otherCategory':
        return localizations.otherCategory;
      default:
        return name;
    }
  }
}
