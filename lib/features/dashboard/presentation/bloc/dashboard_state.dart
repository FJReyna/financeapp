import 'package:finance/features/dashboard/domain/entities/category_spending.dart';
import 'package:finance/features/dashboard/domain/entities/income_expense_data.dart';
import 'package:finance/features/dashboard/domain/entities/today_summary_data.dart';
import 'package:finance/features/dashboard/domain/entities/top_expense_data.dart';
import 'package:finance/features/dashboard/domain/entities/trend_point.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState {
  final DashboardStatus status;
  final double totalBalance;
  final IncomeExpenseData? incomeExpense;
  final TodaySummaryData? todaySummary;
  final TopExpenseData? topExpense;
  final List<CategorySpending> spendingByCategory;
  final List<TrendPoint> monthlyTrend;
  final String? errorMessage;

  const DashboardState._({
    this.status = DashboardStatus.initial,
    this.totalBalance = 0.0,
    this.incomeExpense,
    this.todaySummary,
    this.topExpense,
    this.spendingByCategory = const [],
    this.monthlyTrend = const [],
    this.errorMessage,
  });

  factory DashboardState.initial() => const DashboardState._();

  DashboardState copyWith({
    DashboardStatus? status,
    double? totalBalance,
    IncomeExpenseData? incomeExpense,
    TodaySummaryData? todaySummary,
    TopExpenseData? topExpense,
    List<CategorySpending>? spendingByCategory,
    List<TrendPoint>? monthlyTrend,
    String? errorMessage,
  }) {
    return DashboardState._(
      status: status ?? this.status,
      totalBalance: totalBalance ?? this.totalBalance,
      incomeExpense: incomeExpense ?? this.incomeExpense,
      todaySummary: todaySummary ?? this.todaySummary,
      topExpense: topExpense ?? this.topExpense,
      spendingByCategory: spendingByCategory ?? this.spendingByCategory,
      monthlyTrend: monthlyTrend ?? this.monthlyTrend,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
