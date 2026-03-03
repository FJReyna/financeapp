import 'package:finance/features/category/domain/entites/category.dart';

class CategorySpending {
  final Category category;
  final double amount;
  final double percentage;

  CategorySpending({
    required this.category,
    required this.amount,
    required this.percentage,
  });
}
