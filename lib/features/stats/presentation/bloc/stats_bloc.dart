import 'package:dartz/dartz.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/category/domain/usecases/get_top_categories.dart';
import 'package:finance/features/stats/presentation/bloc/stats_event.dart';
import 'package:finance/features/stats/presentation/bloc/stats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final GetTopCategories _getTopCategories;

  StatsBloc(this._getTopCategories) : super(StatsState.initial()) {
    on<GetTopCategoriesStatsEvent>(_onGetTopCategoriesStats);
  }

  Future<void> _onGetTopCategoriesStats(
    GetTopCategoriesStatsEvent event,
    Emitter<StatsState> emit,
  ) async {
    emit(state.copyWith(topCategoriesStatus: TopCategoriesStatus.loading));
    final Either<Exception, List<Category>> result = await _getTopCategories
        .call(null);
    result.fold(
      (failure) => emit(
        state.copyWith(
          topCategoriesStatus: TopCategoriesStatus.failure,
          errorMessage: failure.toString(),
        ),
      ),
      (categories) => emit(
        state.copyWith(
          topCategoriesStatus: TopCategoriesStatus.success,
          topCategories: categories,
        ),
      ),
    );
  }
}
