class BarChartPoint {
  final int index;
  final double income;
  final double expense;
  final String label;

  BarChartPoint({
    required this.index,
    required this.income,
    required this.expense,
    required this.label,
  });

  double get total => income + expense;
}
