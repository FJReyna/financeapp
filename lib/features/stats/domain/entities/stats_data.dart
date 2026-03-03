import 'package:finance/features/dashboard/domain/entities/category_spending.dart';
import 'package:finance/features/stats/domain/entities/bar_chart_point.dart';

class StatsData {
  final double totalIncome;
  final double totalExpense;
  final List<BarChartPoint> chartData;
  final List<CategorySpending> topCategories;

  StatsData({
    required this.totalIncome,
    required this.totalExpense,
    required this.chartData,
    required this.topCategories,
  });

  double get totalSpent => totalExpense;
  double get balance => totalIncome - totalExpense;
}
