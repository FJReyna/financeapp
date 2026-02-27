// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get income => 'Income';

  @override
  String get expenses => 'Expenses';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get date => 'Date';

  @override
  String get save => 'Save';

  @override
  String get add => 'Add';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get emptyFieldError => 'This field cannot be empty';

  @override
  String get emptyAmountError => 'Amount cannot be empty';

  @override
  String get validAmountError =>
      'Please enter a valid amount greater than zero';

  @override
  String get topExpense => 'Top Expense';

  @override
  String get housingCategory => 'Housing';

  @override
  String get foodCategory => 'Food';

  @override
  String get transportationCategory => 'Transportation';

  @override
  String get entertainmentCategory => 'Entertainment';

  @override
  String get otherCategory => 'Other';

  @override
  String get navbarHome => 'Home';

  @override
  String get navbarTransactions => 'Transactions';

  @override
  String get navbarStats => 'Stats';

  @override
  String get navbarSettings => 'Settings';

  @override
  String get dashboardWelcomeTitle => 'Welcome';

  @override
  String get dashboardTotalBlance => 'Total Balance';

  @override
  String get dashboardQuickSummary => 'Quick Summary';

  @override
  String get dashboardSpendingBreakdown => 'Spending Breakdown';

  @override
  String get dashboardMonthlyTrend => 'Monthly Trend';

  @override
  String get transactionsTitle => 'Transactions';

  @override
  String get transactionsDeleteTitle => 'Delete Transaction';

  @override
  String get transactionsDeleteMessage =>
      'Are you sure you want to delete this transaction?';

  @override
  String get transactionsDeleteSuccess => 'Transaction deleted successfully';

  @override
  String get transactionsDeleteError =>
      'Failed to delete transaction. Please try again.';

  @override
  String get addTransactionTitle => 'Add Transaction';

  @override
  String get addTransactionSuccess => 'Transaction added successfully';

  @override
  String get addTransactionError =>
      'Failed to add transaction. Please try again.';

  @override
  String get addTransactionTitleHint => 'Add a title';

  @override
  String get addTransactionAmountHint => 'Amount';

  @override
  String get categorySelectorTitle => 'Category';

  @override
  String get categorySelectorValidatorError => 'Please select a category';

  @override
  String get addTransactionDescriptionHint => 'Add a description (optional)';

  @override
  String get statisticsTitle => 'Statistics';

  @override
  String get statisticsTotalSpent => 'Total Spent this';

  @override
  String get statisticsTopCategories => 'Top Categories';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsPreferences => 'Preferences';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsCurrency => 'Currency';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsSecurity => 'Security';

  @override
  String get settingsData => 'Data';

  @override
  String get settingsExportData => 'Export Data';

  @override
  String get settingsImportData => 'Import Data';

  @override
  String get settingsSyncData => 'Cloud Sync';

  @override
  String get addCategoryTitle => 'Add Category';

  @override
  String get addCategoryNameLabel => 'Category Name';

  @override
  String get addCategoryIconLabel => 'Select an icon';

  @override
  String get addCategoryIconValidatorError => 'Please select an icon';

  @override
  String get addCategoryColorLabel => 'Select a color';

  @override
  String get addCategoryColorValidatorError => 'Please select a color';

  @override
  String get dashboardErrorLoadingData =>
      'Error loading dashboard data. Please try again.';
}
