import 'package:finance/features/transactions/domain/usecase/add_transaction.dart';
import 'package:finance/features/transactions/domain/usecase/get_all_transactions.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_event.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetAllTransactions _getAllTransactions;
  final AddTransaction _addTransaction;

  TransactionsBloc(this._getAllTransactions, this._addTransaction)
    : super(TransactionsState.initial()) {
    on<GetTransactionsWithCategoryEvent>(_onGetTransactionsEvent);
    on<AddTransactionEvent>(_onAddTransactionEvent);
  }

  Future<void> _onAddTransactionEvent(
    AddTransactionEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(status: TransactionsStatus.submitting));
    try {
      final result = await _addTransaction.call(
        AddTransactionParams(transaction: event.transaction),
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: TransactionsStatus.failure,
            errorMessage: failure.toString(),
          ),
        ),
        (_) {
          emit(state.copyWith(status: TransactionsStatus.submited));
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionsStatus.failure,
          errorMessage: 'Failed to add transaction: $e',
        ),
      );
    }
  }

  Future<void> _onGetTransactionsEvent(
    GetTransactionsWithCategoryEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(status: TransactionsStatus.loading));
    final result = await _getAllTransactions(null);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TransactionsStatus.failure,
          errorMessage: failure.toString(),
        ),
      ),
      (transactions) => emit(
        state.copyWith(
          status: TransactionsStatus.success,
          transactions: transactions,
        ),
      ),
    );
  }
}
