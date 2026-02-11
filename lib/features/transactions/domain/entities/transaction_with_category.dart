import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';

class TransactionWithCategory {
  Transaction transaction;
  Category category;

  TransactionWithCategory({required this.transaction, required this.category});
}
