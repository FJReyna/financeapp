import 'package:finance/core/dependency_injection.dart';
import 'package:finance/core/util/extensions.dart';
import 'package:finance/features/stats/domain/usecases/get_stats_data.dart';
import 'package:finance/features/stats/presentation/bloc/stats_bloc.dart';
import 'package:finance/features/stats/presentation/bloc/stats_event.dart';
import 'package:finance/features/stats/presentation/bloc/stats_state.dart';
import 'package:finance/features/stats/presentation/widgets/bar_chart_stats.dart';
import 'package:finance/features/stats/presentation/widgets/category_desc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsTab extends StatelessWidget {
  final BarChartType type;

  const StatsTab({super.key, this.type = BarChartType.week});

  String _getTotalSpentText(BarChartType type, BuildContext context) {
    switch (type) {
      case BarChartType.week:
        return context.translate.week;
      case BarChartType.month:
        return context.translate.month;
      case BarChartType.year:
        return context.translate.year;
    }
  }

  StatsPeriod _toStatsPeriod(BarChartType type) {
    switch (type) {
      case BarChartType.week:
        return StatsPeriod.week;
      case BarChartType.month:
        return StatsPeriod.month;
      case BarChartType.year:
        return StatsPeriod.year;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatsBloc>(
      create: (context) => getIt<StatsBloc>()
        ..add(LoadStatsData(period: _toStatsPeriod(type))),
      child: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Column(
                children: [
                  Text(
                    '${context.translate.statisticsTotalSpent} ${_getTotalSpentText(type, context).toLowerCase()}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (state.status == StatsStatus.loading)
                    const CircularProgressIndicator()
                  else if (state.status == StatsStatus.success &&
                      state.statsData != null)
                    Text(
                      '\$${state.statsData!.totalExpense.toStringAsFixed(2)}',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    )
                  else
                    Text(
                      '\$0.00',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              BarCharStats(
                type: type,
                chartData: state.statsData?.chartData ?? [],
              ),
              const SizedBox(height: 16),
              Text(
                context.translate.statisticsTopCategories,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              if (state.status == StatsStatus.loading)
                const Center(child: CircularProgressIndicator())
              else if (state.status == StatsStatus.failure)
                Center(
                    child: Text(
                        state.errorMessage ?? 'Failed to load statistics'))
              else if (state.status == StatsStatus.success &&
                  state.statsData != null)
                Column(
                  children: state.statsData!.topCategories.map((category) {
                    return CategoryDesc(
                      icon: category.category.icon,
                      iconColor: category.category.color,
                      title: category.category.localizedName(context),
                    );
                  }).toList(),
                )
              else
                const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
