import 'package:finance/features/category/domain/entites/category.dart';

abstract class CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final Category category;

  AddCategoryEvent(this.category);
}
