import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';

class DeleteTransaction extends UseCase<void, String> {
  final TransactionRepository repository;

  DeleteTransaction(this.repository);

  @override
  Future<Either<Exception, void>> call(String params) async {
    try {
      await repository.deleteTransaction(params);
      return Right(null);
    } catch (e) {
      return Left(Exception('Failed to delete transaction: $e'));
    }
  }
}
