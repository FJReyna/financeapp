import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';

class GetTotalBalance extends UseCase<double, Null> {
  final TransactionRepository repository;

  GetTotalBalance(this.repository);

  @override
  Future<Either<Exception, double>> call(Null params) async {
    try {
      final List<Transaction> transactions = await repository.getTransactions();

      double balance = 0.0;

      for (Transaction transaction in transactions) {
        if (transaction.type == TransactionType.income) {
          balance += transaction.amount;
        } else {
          balance -= transaction.amount;
        }
      }

      return Right(balance);
    } catch (e) {
      return Left(Exception('Failed to calculate total balance: $e'));
    }
  }
}
