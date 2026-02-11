import 'package:finance/features/category/domain/entites/category.dart';

enum CategoriesStatus { initial, loading, success, failure }

class CategoriesState {
  final CategoriesStatus status;
  final List<Category> categories;
  final String? errorMessage;

  const CategoriesState._({
    this.status = CategoriesStatus.initial,
    this.categories = const [],
    this.errorMessage,
  });

  factory CategoriesState.initial() => const CategoriesState._();

  CategoriesState copyWith({
    CategoriesStatus? status,
    List<Category>? categories,
    String? errorMessage,
  }) {
    return CategoriesState._(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
