import 'package:finance/features/dashboard/domain/entities/category_spending.dart';
import 'package:finance/features/dashboard/domain/entities/income_expense_data.dart';
import 'package:finance/features/dashboard/domain/entities/today_summary_data.dart';
import 'package:finance/features/dashboard/domain/entities/top_expense_data.dart';
import 'package:finance/features/dashboard/domain/entities/trend_point.dart';

class DashboardData {
  final double totalBalance;
  final IncomeExpenseData incomeExpense;
  final TodaySummaryData todaySummary;
  final TopExpenseData? topExpense;
  final List<CategorySpending> spendingByCategory;
  final List<TrendPoint> monthlyTrend;

  DashboardData({
    required this.totalBalance,
    required this.incomeExpense,
    required this.todaySummary,
    this.topExpense,
    required this.spendingByCategory,
    required this.monthlyTrend,
  });
}
