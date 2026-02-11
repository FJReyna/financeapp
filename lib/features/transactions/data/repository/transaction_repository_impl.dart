import 'package:finance/features/transactions/data/datasource/transaction_local_datasource.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDatasource localDatasource;

  TransactionRepositoryImpl({required this.localDatasource});

  @override
  Future<void> addTransaction(Transaction transaction) {
    // TODO: implement addTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction(String id) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    final transactionModels = await localDatasource.getAll();
    return transactionModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateTransaction(Transaction transaction) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
