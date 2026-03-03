import 'package:finance/features/settings/domain/entities/app_settings.dart';

enum SettingsStatus { initial, loading, success, failure }

class SettingsState {
  final SettingsStatus status;
  final AppSettings? settings;
  final String? errorMessage;

  const SettingsState._({
    this.status = SettingsStatus.initial,
    this.errorMessage,
    this.settings,
  });

  factory SettingsState.initial() => const SettingsState._();

  SettingsState copyWith({
    SettingsStatus? status,
    String? errorMessage,
    AppSettings? settings,
  }) {
    return SettingsState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      settings: settings ?? this.settings,
    );
  }
}
