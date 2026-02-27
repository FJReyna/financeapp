import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @emptyFieldError.
  ///
  /// In en, this message translates to:
  /// **'This field cannot be empty'**
  String get emptyFieldError;

  /// No description provided for @emptyAmountError.
  ///
  /// In en, this message translates to:
  /// **'Amount cannot be empty'**
  String get emptyAmountError;

  /// No description provided for @validAmountError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount greater than zero'**
  String get validAmountError;

  /// No description provided for @topExpense.
  ///
  /// In en, this message translates to:
  /// **'Top Expense'**
  String get topExpense;

  /// No description provided for @housingCategory.
  ///
  /// In en, this message translates to:
  /// **'Housing'**
  String get housingCategory;

  /// No description provided for @foodCategory.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get foodCategory;

  /// No description provided for @transportationCategory.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get transportationCategory;

  /// No description provided for @entertainmentCategory.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainmentCategory;

  /// No description provided for @otherCategory.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get otherCategory;

  /// No description provided for @navbarHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navbarHome;

  /// No description provided for @navbarTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get navbarTransactions;

  /// No description provided for @navbarStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get navbarStats;

  /// No description provided for @navbarSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navbarSettings;

  /// No description provided for @dashboardWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get dashboardWelcomeTitle;

  /// No description provided for @dashboardTotalBlance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get dashboardTotalBlance;

  /// No description provided for @dashboardQuickSummary.
  ///
  /// In en, this message translates to:
  /// **'Quick Summary'**
  String get dashboardQuickSummary;

  /// No description provided for @dashboardSpendingBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Spending Breakdown'**
  String get dashboardSpendingBreakdown;

  /// No description provided for @dashboardMonthlyTrend.
  ///
  /// In en, this message translates to:
  /// **'Monthly Trend'**
  String get dashboardMonthlyTrend;

  /// No description provided for @transactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactionsTitle;

  /// No description provided for @transactionsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Transaction'**
  String get transactionsDeleteTitle;

  /// No description provided for @transactionsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this transaction?'**
  String get transactionsDeleteMessage;

  /// No description provided for @transactionsDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted successfully'**
  String get transactionsDeleteSuccess;

  /// No description provided for @transactionsDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete transaction. Please try again.'**
  String get transactionsDeleteError;

  /// No description provided for @addTransactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Transaction'**
  String get addTransactionTitle;

  /// No description provided for @addTransactionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Transaction added successfully'**
  String get addTransactionSuccess;

  /// No description provided for @addTransactionError.
  ///
  /// In en, this message translates to:
  /// **'Failed to add transaction. Please try again.'**
  String get addTransactionError;

  /// No description provided for @addTransactionTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Add a title'**
  String get addTransactionTitleHint;

  /// No description provided for @addTransactionAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get addTransactionAmountHint;

  /// No description provided for @categorySelectorTitle.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categorySelectorTitle;

  /// No description provided for @categorySelectorValidatorError.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get categorySelectorValidatorError;

  /// No description provided for @addTransactionDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Add a description (optional)'**
  String get addTransactionDescriptionHint;

  /// No description provided for @statisticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statisticsTitle;

  /// No description provided for @statisticsTotalSpent.
  ///
  /// In en, this message translates to:
  /// **'Total Spent this'**
  String get statisticsTotalSpent;

  /// No description provided for @statisticsTopCategories.
  ///
  /// In en, this message translates to:
  /// **'Top Categories'**
  String get statisticsTopCategories;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsPreferences;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get settingsCurrency;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsSecurity;

  /// No description provided for @settingsData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settingsData;

  /// No description provided for @settingsExportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get settingsExportData;

  /// No description provided for @settingsImportData.
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get settingsImportData;

  /// No description provided for @settingsSyncData.
  ///
  /// In en, this message translates to:
  /// **'Cloud Sync'**
  String get settingsSyncData;

  /// No description provided for @addCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategoryTitle;

  /// No description provided for @addCategoryNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get addCategoryNameLabel;

  /// No description provided for @addCategoryIconLabel.
  ///
  /// In en, this message translates to:
  /// **'Select an icon'**
  String get addCategoryIconLabel;

  /// No description provided for @addCategoryIconValidatorError.
  ///
  /// In en, this message translates to:
  /// **'Please select an icon'**
  String get addCategoryIconValidatorError;

  /// No description provided for @addCategoryColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Select a color'**
  String get addCategoryColorLabel;

  /// No description provided for @addCategoryColorValidatorError.
  ///
  /// In en, this message translates to:
  /// **'Please select a color'**
  String get addCategoryColorValidatorError;

  /// No description provided for @dashboardErrorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading dashboard data. Please try again.'**
  String get dashboardErrorLoadingData;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
