import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/category/domain/repository/category_repository.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';
import 'package:flutter/material.dart';

class TopExpenseData {
  final Transaction transaction;
  final Category category;

  TopExpenseData({required this.transaction, required this.category});
}

class GetTopExpense extends UseCase<TopExpenseData?, Null> {
  final TransactionRepository transactionRepository;
  final CategoryRepository categoryRepository;

  GetTopExpense(this.transactionRepository, this.categoryRepository);

  @override
  Future<Either<Exception, TopExpenseData?>> call(Null params) async {
    try {
      final List<Transaction> transactions = await transactionRepository
          .getTransactions();

      final List<Transaction> expenses = transactions
          .where((t) => t.type == TransactionType.expense)
          .toList();

      if (expenses.isEmpty) {
        return const Right(null);
      }

      expenses.sort(
        (Transaction a, Transaction b) => b.amount.compareTo(a.amount),
      );
      final topExpense = expenses.first;

      final List<Category> categories = await categoryRepository
          .getCategories();
      final Category category = categories.firstWhere(
        (cat) => cat.id == topExpense.categoryId,
        orElse: () => Category(
          id: 'unknown',
          name: 'Unknown',
          icon: Icons.help_outline,
          color: Colors.grey,
        ),
      );

      return Right(TopExpenseData(transaction: topExpense, category: category));
    } catch (e) {
      return Left(Exception('Failed to get top expense: $e'));
    }
  }
}
