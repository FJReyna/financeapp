import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';

class GetTransaction extends UseCase<Transaction, String> {
  final TransactionRepository _repository;

  GetTransaction(this._repository);

  @override
  Future<Either<Exception, Transaction>> call(String params) async {
    try {
      final transaction = await _repository.getTransaction(params);
      return Right(transaction);
    } catch (e) {
      return Left(Exception('Failed to get transaction: $e'));
    }
  }
}
