import 'package:finance/features/transactions/domain/usecase/get_all_transactions.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_event.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetAllTransactions _getAllTransactions;

  TransactionsBloc(this._getAllTransactions)
    : super(TransactionsState.initial()) {
    on<GetTransactionsWithCategoryEvent>(_onGetTransactionsEvent);
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
