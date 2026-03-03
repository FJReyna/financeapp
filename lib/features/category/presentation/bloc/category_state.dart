enum CategoryStatus { initial, loading, success, failure }

class CategoryState {
  final CategoryStatus status;
  final String? errorMessage;

  const CategoryState._({
    this.status = CategoryStatus.initial,
    this.errorMessage,
  });

  factory CategoryState.initial() => const CategoryState._();

  CategoryState copyWith({CategoryStatus? status, String? errorMessage}) {
    return CategoryState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
