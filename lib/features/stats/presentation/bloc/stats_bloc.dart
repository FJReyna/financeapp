import 'package:dartz/dartz.dart';
import 'package:finance/features/stats/domain/entities/stats_data.dart';
import 'package:finance/features/stats/domain/usecases/get_stats_data.dart';
import 'package:finance/features/stats/presentation/bloc/stats_event.dart';
import 'package:finance/features/stats/presentation/bloc/stats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final GetStatsData _getStatsData;

  StatsBloc(this._getStatsData) : super(StatsState.initial()) {
    on<LoadStatsData>(_onLoadStatsData);
  }

  Future<void> _onLoadStatsData(
    LoadStatsData event,
    Emitter<StatsState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));

    try {
      final Either<Exception, StatsData> result = await _getStatsData.call(
        StatsParams(period: event.period),
      );

      result.fold(
        (failure) => emit(
          state.copyWith(
            status: StatsStatus.failure,
            errorMessage: failure.toString(),
          ),
        ),
        (data) => emit(
          state.copyWith(
            status: StatsStatus.success,
            statsData: data,
            errorMessage: null,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StatsStatus.failure,
          errorMessage: 'Failed to load stats: $e',
        ),
      );
    }
  }
}
