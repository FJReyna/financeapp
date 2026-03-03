import 'package:finance/features/stats/domain/usecases/get_stats_data.dart';

abstract class StatsEvent {}

class LoadStatsData extends StatsEvent {
  final StatsPeriod period;

  LoadStatsData({required this.period});
}
