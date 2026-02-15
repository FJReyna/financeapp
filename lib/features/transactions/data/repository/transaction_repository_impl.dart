import 'package:finance/features/transactions/data/datasource/transaction_local_datasource.dart';
import 'package:finance/features/transactions/data/model/transaction_model.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDatasource localDatasource;

  TransactionRepositoryImpl({required this.localDatasource});

  @override
  Future<void> addTransaction(Transaction transaction) async {
    await localDatasource.add(TransactionModel.fromEntity(transaction));
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await localDatasource.delete(id);
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
