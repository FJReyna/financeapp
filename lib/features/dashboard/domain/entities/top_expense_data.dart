import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';

class TopExpenseData {
  final Transaction transaction;
  final Category category;

  TopExpenseData({required this.transaction, required this.category});
}
