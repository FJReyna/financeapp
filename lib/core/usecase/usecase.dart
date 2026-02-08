import 'package:dartz/dartz.dart';

abstract class UseCase<T, Params> {
  Future<Either<Exception, T>> call(Params params);
}
