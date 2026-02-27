import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/category/domain/repository/category_repository.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';
import 'package:flutter/material.dart';

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

class GetSpendingByCategory extends UseCase<List<CategorySpending>, Null> {
  final TransactionRepository transactionRepository;
  final CategoryRepository categoryRepository;

  GetSpendingByCategory(this.transactionRepository, this.categoryRepository);

  @override
  Future<Either<Exception, List<CategorySpending>>> call(Null params) async {
    try {
      final List<Transaction> transactions = await transactionRepository
          .getTransactions();
      final List<Category> categories = await categoryRepository
          .getCategories();

      final List<Transaction> expenses = transactions
          .where((t) => t.type == TransactionType.expense)
          .toList();

      final double totalExpense = expenses.fold<double>(
        0.0,
        (double sum, Transaction transaction) => sum + transaction.amount,
      );

      final Map<String, double> categoryTotals = {};

      for (Transaction transaction in expenses) {
        categoryTotals[transaction.categoryId] =
            (categoryTotals[transaction.categoryId] ?? 0.0) +
            transaction.amount;
      }

      final List<CategorySpending> result = [];

      for (MapEntry<String, double> entry in categoryTotals.entries) {
        final category = categories.firstWhere(
          (cat) => cat.id == entry.key,
          orElse: () => Category(
            id: 'unknown',
            name: 'Unknown',
            icon: Icons.help_outline,
            color: Colors.grey,
          ),
        );

        result.add(
          CategorySpending(
            category: category,
            amount: entry.value,
            percentage: totalExpense > 0 ? (entry.value / totalExpense) : 0.0,
          ),
        );
      }

      result.sort(
        (CategorySpending a, CategorySpending b) =>
            b.amount.compareTo(a.amount),
      );

      return Right(result);
    } catch (e) {
      return Left(Exception('Failed to get spending by category: $e'));
    }
  }
}
