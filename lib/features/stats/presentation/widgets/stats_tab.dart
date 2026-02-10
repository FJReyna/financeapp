import 'package:finance/core/dependency_injection.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatsBloc>(
      create: (context) =>
          getIt<StatsBloc>()..add(GetTopCategoriesStatsEvent()),
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Column(
            children: [
              Text(
                'Total spent this ${type.name}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '\$2450.00',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          BarCharStats(type: type),
          SizedBox(height: 16),
          Text(
            'Top categories',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          BlocBuilder<StatsBloc, StatsState>(
            builder: (context, state) {
              if (state.topCategoriesStatus == TopCategoriesStatus.loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.topCategoriesStatus ==
                  TopCategoriesStatus.failure) {
                return Center(child: Text('Failed to load top categories'));
              } else if (state.topCategoriesStatus ==
                  TopCategoriesStatus.success) {
                return Column(
                  children: state.topCategories.map((category) {
                    return CategoryDesc(
                      icon: category.icon,
                      iconColor: category.color,
                      title: category.name,
                    );
                  }).toList(),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
