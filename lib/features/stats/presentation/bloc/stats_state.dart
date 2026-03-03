import 'package:finance/features/stats/domain/entities/stats_data.dart';

enum StatsStatus { initial, loading, success, failure }

class StatsState {
  final StatsStatus status;
  final StatsData? statsData;
  final String? errorMessage;

  const StatsState._({
    this.status = StatsStatus.initial,
    this.statsData,
    this.errorMessage,
  });

  factory StatsState.initial() => const StatsState._();

  StatsState copyWith({
    StatsStatus? status,
    StatsData? statsData,
    String? errorMessage,
  }) {
    return StatsState._(
      status: status ?? this.status,
      statsData: statsData ?? this.statsData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
