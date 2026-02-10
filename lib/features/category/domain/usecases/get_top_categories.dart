import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/category/domain/repository/category_repository.dart';

class GetTopCategories extends UseCase<List<Category>, Null> {
  final CategoryRepository _repository;

  GetTopCategories(this._repository);

  @override
  Future<Either<Exception, List<Category>>> call(Null params) async {
    List<Category> categories = [];
    try {
      categories = await _repository.getCategories();
      return Right(categories.toList());
    } catch (e) {
      return Left(Exception('Failed to get top categories: $e'));
    }
  }
}
