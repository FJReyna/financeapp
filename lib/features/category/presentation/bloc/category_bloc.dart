import 'package:dartz/dartz.dart';
import 'package:finance/features/category/domain/usecases/add_category.dart';
import 'package:finance/features/category/presentation/bloc/category_event.dart';
import 'package:finance/features/category/presentation/bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final AddCategory addCategory;

  CategoryBloc(this.addCategory) : super(CategoryState.initial()) {
    on<AddCategoryEvent>(_onAddCategory);
  }

  Future<void> _onAddCategory(
    AddCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      await Future.delayed(Duration(seconds: 2));
      final Either<Exception, void> result = await addCategory.call(
        AddCategoryParams(category: event.category),
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: CategoryStatus.failure,
            errorMessage: failure.toString(),
          ),
        ),
        (_) => emit(state.copyWith(status: CategoryStatus.success)),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CategoryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
