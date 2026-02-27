import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';

class TodaySummaryData {
  final double income;
  final double expense;
  final int transactionCount;

  TodaySummaryData({
    required this.income,
    required this.expense,
    required this.transactionCount,
  });

  double get balance => income - expense;
}

class GetTodaySummary extends UseCase<TodaySummaryData, Null> {
  final TransactionRepository repository;

  GetTodaySummary(this.repository);

  @override
  Future<Either<Exception, TodaySummaryData>> call(Null params) async {
    try {
      final transactions = await repository.getTransactions();
      final now = DateTime.now();

      final todayTransactions = transactions.where((transaction) {
        return transaction.date.year == now.year &&
            transaction.date.month == now.month &&
            transaction.date.day == now.day;
      }).toList();

      double totalIncome = 0.0;
      double totalExpense = 0.0;

      for (var transaction in todayTransactions) {
        if (transaction.type == TransactionType.income) {
          totalIncome += transaction.amount;
        } else {
          totalExpense += transaction.amount;
        }
      }

      return Right(
        TodaySummaryData(
          income: totalIncome,
          expense: totalExpense,
          transactionCount: todayTransactions.length,
        ),
      );
    } catch (e) {
      return Left(Exception('Failed to get today summary: $e'));
    }
  }
}
