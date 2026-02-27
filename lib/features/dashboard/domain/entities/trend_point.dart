/// Modelo para un punto de datos en la tendencia mensual
class TrendPoint {
  final DateTime date;
  final double income;
  final double expense;
  final double x;

  TrendPoint({
    required this.date,
    required this.income,
    required this.expense,
    required this.x,
  });

  double get balance => income - expense;
}
