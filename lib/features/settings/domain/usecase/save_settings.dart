import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/settings/domain/entities/app_settings.dart';
import 'package:finance/features/settings/domain/repository/settings_repository.dart';

class SaveSettings extends UseCase<void, SaveSettingsParams> {
  final SettingsRepository _repository;

  SaveSettings(this._repository);

  @override
  Future<Either<Exception, void>> call(SaveSettingsParams params) async {
    try {
      await _repository.saveSettings(params.settings);
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to save settings: ${e.toString()}'));
    }
  }
}

class SaveSettingsParams {
  AppSettings settings;

  SaveSettingsParams(this.settings);
}
