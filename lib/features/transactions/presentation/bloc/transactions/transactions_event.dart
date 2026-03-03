import 'package:finance/features/transactions/domain/entities/transaction.dart';

abstract class TransactionsEvent {}

class GetTransactionsWithCategoryEvent extends TransactionsEvent {}

class GetTransactionEvent extends TransactionsEvent {
  final String transactionId;

  GetTransactionEvent({required this.transactionId});
}

class AddTransactionEvent extends TransactionsEvent {
  final Transaction transaction;

  AddTransactionEvent({required this.transaction});
}

class DeleteTransactionEvent extends TransactionsEvent {
  final String transactionId;
  final String successMessage;

  DeleteTransactionEvent({
    required this.transactionId,
    required this.successMessage,
  });
}
