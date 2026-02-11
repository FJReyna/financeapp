import 'package:finance/features/transactions/domain/entities/transaction.dart';

abstract class TransactionsEvent {}

class GetTransactionsWithCategoryEvent extends TransactionsEvent {}

class AddTransactionEvent extends TransactionsEvent {
  final Transaction transaction;

  AddTransactionEvent({required this.transaction});
}
