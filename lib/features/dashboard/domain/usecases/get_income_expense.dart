import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';

class IncomeExpenseData {
  final double income;
  final double expense;

  IncomeExpenseData({required this.income, required this.expense});
}

class GetIncomeExpense extends UseCase<IncomeExpenseData, Null> {
  final TransactionRepository repository;

  GetIncomeExpense(this.repository);

  @override
  Future<Either<Exception, IncomeExpenseData>> call(Null params) async {
    try {
      final List<Transaction> transactions = await repository.getTransactions();

      double totalIncome = 0.0;
      double totalExpense = 0.0;

      for (Transaction transaction in transactions) {
        if (transaction.type == TransactionType.income) {
          totalIncome += transaction.amount;
        } else {
          totalExpense += transaction.amount;
        }
      }

      return Right(
        IncomeExpenseData(income: totalIncome, expense: totalExpense),
      );
    } catch (e) {
      return Left(Exception('Failed to calculate income and expense: $e'));
    }
  }
}
