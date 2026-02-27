class TodaySummaryData {
  final double income;
  final double expense;
  final int transactionCount;

  TodaySummaryData({
    required this.income,
    required this.expense,
    required this.transactionCount,
  });

  double get balance => income - expense;
}
