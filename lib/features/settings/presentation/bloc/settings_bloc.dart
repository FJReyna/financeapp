import 'package:dartz/dartz.dart';
import 'package:finance/core/util/pin_service.dart';
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
    on<EnablePinEvent>(_onEnablePin);
    on<DisablePinEvent>(_onDisablePin);
    on<ChangePinEvent>(_onChangePin);
    on<VerifyPinEvent>(_onVerifyPin);
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

  Future<void> _onEnablePin(
    EnablePinEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.settings == null) return;

    if (!PinService.isValidPin(event.pin)) {
      emit(
        state.copyWith(
          status: SettingsStatus.failure,
          errorMessage: 'PIN must be 4-6 digits',
        ),
      );
      return;
    }

    final pinHash = PinService.hashPin(event.pin);
    final updatedSettings = state.settings!.copyWith(
      pinEnabled: true,
      pinHash: pinHash,
    );
    add(SaveSettingsEvent(updatedSettings));
  }

  Future<void> _onDisablePin(
    DisablePinEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.settings == null || state.settings!.pinHash == null) return;

    if (!PinService.verifyPin(event.currentPin, state.settings!.pinHash!)) {
      emit(
        state.copyWith(
          status: SettingsStatus.failure,
          errorMessage: 'Incorrect PIN',
        ),
      );
      return;
    }

    final updatedSettings = state.settings!.copyWith(
      pinEnabled: false,
      pinHash: null,
    );
    add(SaveSettingsEvent(updatedSettings));
  }

  Future<void> _onChangePin(
    ChangePinEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.settings == null || state.settings!.pinHash == null) return;

    if (!PinService.verifyPin(event.oldPin, state.settings!.pinHash!)) {
      emit(
        state.copyWith(
          status: SettingsStatus.failure,
          errorMessage: 'Incorrect current PIN',
        ),
      );
      return;
    }

    if (!PinService.isValidPin(event.newPin)) {
      emit(
        state.copyWith(
          status: SettingsStatus.failure,
          errorMessage: 'New PIN must be 4-6 digits',
        ),
      );
      return;
    }

    final newPinHash = PinService.hashPin(event.newPin);
    final updatedSettings = state.settings!.copyWith(pinHash: newPinHash);
    add(SaveSettingsEvent(updatedSettings));
  }

  Future<void> _onVerifyPin(
    VerifyPinEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.settings == null || state.settings!.pinHash == null) {
      emit(
        state.copyWith(
          status: SettingsStatus.failure,
          errorMessage: 'No PIN configured',
        ),
      );
      return;
    }

    if (PinService.verifyPin(event.pin, state.settings!.pinHash!)) {
      emit(state.copyWith(status: SettingsStatus.success));
    } else {
      emit(
        state.copyWith(
          status: SettingsStatus.failure,
          errorMessage: 'Incorrect PIN',
        ),
      );
    }
  }
}
