import 'package:dartz/dartz.dart';
import 'package:finance/core/dependency_injection.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/category/domain/repository/category_repository.dart';
import 'package:uuid/uuid.dart';

class AddCategory extends UseCase<void, AddCategoryParams> {
  final CategoryRepository _repository;

  AddCategory(this._repository);

  @override
  Future<Either<Exception, void>> call(AddCategoryParams params) async {
    try {
      await _repository.addCategory(
        params.category.copyWith(id: getIt<Uuid>().v4()),
      );
      return Right(null);
    } catch (e) {
      return Left(Exception('Failed to add category: $e'));
    }
  }
}

class AddCategoryParams {
  final Category category;

  AddCategoryParams({required this.category});
}
