import 'package:finance/features/category/data/datasource/local/category_local_datasource.dart';
import 'package:finance/features/category/data/model/category_model.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/category/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDatasource _localDatasource;

  CategoryRepositoryImpl(this._localDatasource);

  @override
  Future<void> addCategory(Category category) async {
    final model = CategoryModel.fromEntity(category);
    await _localDatasource.add(model);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _localDatasource.delete(id);
  }

  @override
  Future<List<Category>> getCategories(int limit) async {
    final models = await _localDatasource.getAll();
    return models.map((model) => model.toEntity()).take(limit).toList();
  }

  @override
  Future<void> updateCategory(Category category) async {
    final model = CategoryModel.fromEntity(category);
    await _localDatasource.add(model);
  }
}
