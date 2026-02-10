import 'package:finance/features/transactions/domain/entitites/transaction_with_category.dart';

enum TransactionsStatus { initial, loading, success, failure }

class TransactionsState {
  final TransactionsStatus status;
  final List<TransactionWithCategory> transactions;
  final String? errorMessage;

  const TransactionsState._({
    this.status = TransactionsStatus.initial,
    this.transactions = const [],
    this.errorMessage,
  });

  factory TransactionsState.initial() => const TransactionsState._();

  TransactionsState copyWith({
    TransactionsStatus? status,
    List<TransactionWithCategory>? transactions,
    String? errorMessage,
  }) {
    return TransactionsState._(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
