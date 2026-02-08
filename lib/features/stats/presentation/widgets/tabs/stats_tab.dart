import 'package:finance/features/stats/presentation/widgets/bar_chart_stats.dart';
import 'package:finance/features/stats/presentation/widgets/category_desc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatsTab extends StatelessWidget {
  final BarChartType type;

  const StatsTab({super.key, this.type = BarChartType.week});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
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
        Column(
          children: [
            CategoryDesc(
              icon: FontAwesomeIcons.house,
              iconColor: Colors.blue,
              title: 'Housing',
            ),
            CategoryDesc(
              icon: FontAwesomeIcons.utensils,
              iconColor: Colors.orange,
              title: 'Food & Drinking',
            ),
            CategoryDesc(
              icon: FontAwesomeIcons.car,
              iconColor: Colors.green,
              title: 'Transportation',
            ),
            CategoryDesc(
              icon: FontAwesomeIcons.film,
              iconColor: Colors.pink,
              title: 'Entertainment',
            ),
          ],
        ),
      ],
    );
  }
}
