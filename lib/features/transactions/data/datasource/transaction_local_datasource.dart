import 'dart:math';

import 'package:finance/core/dependency_injection.dart';
import 'package:finance/features/transactions/data/model/transaction_model.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

class TransactionLocalDatasource {
  final Box<TransactionModel> box;

  TransactionLocalDatasource(this.box);

  Future<List<TransactionModel>> getAll() async {
    return box.values.toList();
  }

  Future<TransactionModel> get(String id) async {
    return box.get(id)!;
  }

  Future<void> add(TransactionModel transaction) async {
    await box.put(transaction.id, transaction);
  }

  Future<void> delete(String id) async {
    await box.delete(id);
  }

  Future<bool> seed(List<String> categoryIds) async {
    if (box.isEmpty) {
      final Uuid uuid = getIt<Uuid>();
      final Random random = Random();
      final defaultTransactions = [
        TransactionModel(
          id: uuid.v7(),
          title: 'Salad',
          amount: 200.0,
          date: DateTime.now(),
          categoryId: categoryIds[random.nextInt(categoryIds.length)],
          description: 'Grocery shopping',
          type: 0,
        ),
        TransactionModel(
          id: uuid.v7(),
          title: 'Dinner',
          amount: 1200.0,
          date: DateTime.now(),
          categoryId: categoryIds[random.nextInt(categoryIds.length)],
          description: 'Dinner at restaurant',
          type: 1,
        ),
        TransactionModel(
          id: uuid.v7(),
          title: 'Bus Pass',
          amount: 500.0,
          date: DateTime.now().subtract(Duration(days: 1)),
          categoryId: categoryIds[random.nextInt(categoryIds.length)],
          description: 'Monthly bus pass',
          type: 1,
        ),
        TransactionModel(
          id: uuid.v7(),
          title: 'Movie Ticket',
          amount: 150.0,
          date: DateTime.now().subtract(Duration(days: 2)),
          categoryId: categoryIds[random.nextInt(categoryIds.length)],
          description: 'Movie ticket',
          type: 0,
        ),
      ];

      for (var transaction in defaultTransactions) {
        await box.put(transaction.id, transaction);
      }
      return true;
    }
    return false;
  }
}
