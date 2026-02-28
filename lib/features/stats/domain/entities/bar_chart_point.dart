class BarChartPoint {
  final int index;
  final double income;
  final double expense;

  BarChartPoint({
    required this.index,
    required this.income,
    required this.expense,
  });

  double get total => income + expense;
}
