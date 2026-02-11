import 'package:dartz/dartz.dart';
import 'package:finance/core/dependency_injection.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';
import 'package:uuid/uuid.dart';

class AddTransaction extends UseCase<void, AddTransactionParams> {
  final TransactionRepository _transactionRepository;

  AddTransaction(this._transactionRepository);

  @override
  Future<Either<Exception, void>> call(AddTransactionParams params) async {
    try {
      await _transactionRepository.addTransaction(
        params.transaction.copyWith(id: getIt<Uuid>().v7()),
      );
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to add transaction: $e'));
    }
  }
}

class AddTransactionParams {
  final Transaction transaction;

  AddTransactionParams({required this.transaction});
}
