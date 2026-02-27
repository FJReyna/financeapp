import 'package:dartz/dartz.dart';
import 'package:finance/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:finance/features/dashboard/domain/usecases/get_dashboard_data.dart';
import 'package:finance/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:finance/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardData _getDashboardData;

  DashboardBloc(this._getDashboardData) : super(DashboardState.initial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<RefreshDashboardData>(_onRefreshDashboardData);
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    await _loadAllData(emit);
  }

  Future<void> _onRefreshDashboardData(
    RefreshDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    await _loadAllData(emit);
  }

  Future<void> _loadAllData(Emitter<DashboardState> emit) async {
    try {
      final Either<Exception, DashboardData> result = await _getDashboardData
          .call(null);

      result.fold(
        (failure) => emit(
          state.copyWith(
            status: DashboardStatus.failure,
            errorMessage: failure.toString(),
          ),
        ),
        (data) => emit(
          state.copyWith(
            status: DashboardStatus.success,
            totalBalance: data.totalBalance,
            incomeExpense: data.incomeExpense,
            todaySummary: data.todaySummary,
            topExpense: data.topExpense,
            spendingByCategory: data.spendingByCategory,
            monthlyTrend: data.monthlyTrend,
            errorMessage: null,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: 'Failed to load dashboard data: $e',
        ),
      );
    }
  }
}
