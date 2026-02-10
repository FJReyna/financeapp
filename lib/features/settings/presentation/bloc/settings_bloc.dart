import 'package:dartz/dartz.dart';
import 'package:finance/features/settings/domain/entities/app_settings.dart';
import 'package:finance/features/settings/domain/usecase/get_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/features/settings/presentation/bloc/settings_event.dart';
import 'package:finance/features/settings/presentation/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings _getSettings;

  SettingsBloc(this._getSettings) : super(SettingsState.initial()) {
    on<GetSettingsEvent>(_onGetSettings);
  }

  Future<void> _onGetSettings(
    GetSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(status: SettingsStatus.loading));
    try {
      final Either<Exception, AppSettings> result = await _getSettings.call(
        null,
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: SettingsStatus.failure,
              errorMessage: failure.toString(),
            ),
          );
        },
        (settings) {
          emit(
            state.copyWith(status: SettingsStatus.success, settings: settings),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SettingsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
