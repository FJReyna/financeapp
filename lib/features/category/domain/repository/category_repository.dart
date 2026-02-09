import 'package:finance/features/category/domain/entites/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories(int limit);
  Future<void> addCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(String id);
}
