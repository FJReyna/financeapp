import 'package:finance/features/category/domain/usecases/get_all_categories.dart';
import 'package:finance/features/transactions/presentation/bloc/categories/categories_event.dart';
import 'package:finance/features/transactions/presentation/bloc/categories/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetAllCategories _getCategories;

  CategoriesBloc(this._getCategories) : super(CategoriesState.initial()) {
    on<GetCategoriesEvent>(_onGetCategories);
  }

  Future<void> _onGetCategories(
    GetCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(state.copyWith(status: CategoriesStatus.loading));
    try {
      final result = await _getCategories.call(null);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: CategoriesStatus.failure,
              errorMessage: failure.toString(),
            ),
          );
        },
        (categories) {
          emit(
            state.copyWith(
              status: CategoriesStatus.success,
              categories: categories,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CategoriesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
