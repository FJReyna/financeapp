import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/settings/domain/entities/app_settings.dart';
import 'package:finance/features/settings/domain/repository/settings_repository.dart';

class GetSettings extends UseCase<AppSettings, Null> {
  final SettingsRepository _repository;

  GetSettings(this._repository);

  @override
  Future<Either<Exception, AppSettings>> call(Null params) async {
    try {
      final settings = await _repository.getSettings();
      return Right(settings);
    } catch (e) {
      return Left(Exception('Failed to get settings: $e'));
    }
  }
}
