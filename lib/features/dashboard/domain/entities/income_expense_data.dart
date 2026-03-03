class IncomeExpenseData {
  final double income;
  final double expense;

  IncomeExpenseData({required this.income, required this.expense});

  double get balance => income - expense;
}
