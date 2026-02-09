import 'package:finance/features/category/domain/entites/category.dart';

enum TopCategoriesStatus { initial, loading, success, failure }

class StatsState {
  final TopCategoriesStatus topCategoriesStatus;
  final List<Category> topCategories;
  final String? errorMessage;

  StatsState._({
    this.topCategoriesStatus = TopCategoriesStatus.initial,
    this.topCategories = const [],
    this.errorMessage,
  });

  factory StatsState.initial() => StatsState._();

  StatsState copyWith({
    TopCategoriesStatus? topCategoriesStatus,
    List<Category>? topCategories,
    String? errorMessage,
  }) {
    return StatsState._(
      topCategoriesStatus: topCategoriesStatus ?? this.topCategoriesStatus,
      topCategories: topCategories ?? this.topCategories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
