import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/entities/transaction_with_category.dart';

enum TransactionsStatus {
  initial,
  loading,
  loadingList,
  submitting,
  submited,
  success,
  failure,
}

class TransactionsState {
  final TransactionsStatus status;
  final List<TransactionWithCategory> transactions;
  final Transaction? transaction;
  final String? errorMessage;
  final String? successMessage;

  const TransactionsState._({
    this.status = TransactionsStatus.initial,
    this.transactions = const [],
    this.transaction,
    this.errorMessage,
    this.successMessage,
  });

  factory TransactionsState.initial() => const TransactionsState._();

  TransactionsState copyWith({
    TransactionsStatus? status,
    List<TransactionWithCategory>? transactions,
    Transaction? transaction,
    String? errorMessage,
    String? successMessage,
  }) {
    return TransactionsState._(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      transaction: transaction ?? this.transaction,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}
