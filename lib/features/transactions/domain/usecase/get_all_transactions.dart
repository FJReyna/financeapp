import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/category/domain/repository/category_repository.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/entities/transaction_with_category.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GetAllTransactions extends UseCase<List<TransactionWithCategory>, Null> {
  final TransactionRepository repository;
  final CategoryRepository categoryRepository;

  GetAllTransactions(this.repository, this.categoryRepository);

  @override
  Future<Either<Exception, List<TransactionWithCategory>>> call(Null p) async {
    List<TransactionWithCategory> transactionsWithCategory = [];
    try {
      List<Transaction> transactions = await repository.getTransactions();
      for (var transaction in transactions) {
        late Category category;
        final categories = await categoryRepository.getCategories();
        category = categories.firstWhere(
          (cat) => cat.id == transaction.categoryId,
          orElse: () => Category(
            id: 'unknown',
            name: 'Unknown',
            color: Colors.orange,
            icon: FontAwesomeIcons.triangleExclamation,
          ),
        );
        transactionsWithCategory.add(
          TransactionWithCategory(transaction: transaction, category: category),
        );
      }
      return Right(transactionsWithCategory.toList());
    } catch (e) {
      return Left(Exception('Failed to get transactions: $e'));
    }
  }
}
