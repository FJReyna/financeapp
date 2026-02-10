import 'package:dartz/dartz.dart';
import 'package:finance/features/settings/domain/entities/app_settings.dart';
import 'package:finance/features/settings/domain/usecase/get_settings.dart';
import 'package:finance/features/settings/domain/usecase/save_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/features/settings/presentation/bloc/settings_event.dart';
import 'package:finance/features/settings/presentation/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings _getSettings;
  final SaveSettings _saveSettings;

  SettingsBloc(this._getSettings, this._saveSettings)
    : super(SettingsState.initial()) {
    on<GetSettingsEvent>(_onGetSettings);
    on<SaveSettingsEvent>(_onSaveSettings);
    on<ChangeThemeEvent>(_onChangeTheme);
    on<ChangeCurrencyEvent>(_onChangeCurrency);
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

  Future<void> _onSaveSettings(SaveSettingsEvent event, Emitter emit) async {
    emit(state.copyWith(status: SettingsStatus.loading));
    try {
      final result = await _saveSettings.call(
        SaveSettingsParams(event.settings),
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
        (_) {
          emit(
            state.copyWith(
              status: SettingsStatus.success,
              settings: event.settings,
            ),
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

  Future<void> _onChangeTheme(
    ChangeThemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.settings == null) return;

    final updatedSettings = state.settings!.copyWith(
      themeMode: event.themeMode,
    );
    add(SaveSettingsEvent(updatedSettings));
  }

  Future<void> _onChangeCurrency(
    ChangeCurrencyEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.settings == null) return;

    final updatedSettings = state.settings!.copyWith(currency: event.currency);
    add(SaveSettingsEvent(updatedSettings));
  }
}
