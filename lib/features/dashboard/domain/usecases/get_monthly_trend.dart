import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';

class TrendPoint {
  final DateTime date;
  final double income;
  final double expense;

  TrendPoint({required this.date, required this.income, required this.expense});

  double get balance => income - expense;
}

class GetMonthlyTrend extends UseCase<List<TrendPoint>, Null> {
  final TransactionRepository repository;

  GetMonthlyTrend(this.repository);

  @override
  Future<Either<Exception, List<TrendPoint>>> call(Null params) async {
    try {
      final List<Transaction> transactions = await repository.getTransactions();
      final DateTime now = DateTime.now();
      final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
      final DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

      final List<Transaction> monthTransactions = transactions.where((
        transaction,
      ) {
        return transaction.date.isAfter(
              firstDayOfMonth.subtract(const Duration(days: 1)),
            ) &&
            transaction.date.isBefore(
              lastDayOfMonth.add(const Duration(days: 1)),
            );
      }).toList();

      final Map<int, TrendPoint> dailyData = {};

      for (Transaction transaction in monthTransactions) {
        final int day = transaction.date.day;

        if (!dailyData.containsKey(day)) {
          dailyData[day] = TrendPoint(
            date: DateTime(now.year, now.month, day),
            income: 0.0,
            expense: 0.0,
          );
        }

        if (transaction.type == TransactionType.income) {
          dailyData[day] = TrendPoint(
            date: dailyData[day]!.date,
            income: dailyData[day]!.income + transaction.amount,
            expense: dailyData[day]!.expense,
          );
        } else {
          dailyData[day] = TrendPoint(
            date: dailyData[day]!.date,
            income: dailyData[day]!.income,
            expense: dailyData[day]!.expense + transaction.amount,
          );
        }
      }

      final List<TrendPoint> result = dailyData.values.toList();
      result.sort((TrendPoint a, TrendPoint b) => a.date.compareTo(b.date));

      return Right(result);
    } catch (e) {
      return Left(Exception('Failed to get monthly trend: $e'));
    }
  }
}
