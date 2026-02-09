import 'package:finance/core/widgets/bottom_nav_bar.dart';
import 'package:finance/features/stats/presentation/widgets/bar_chart_stats.dart';
import 'package:finance/features/stats/presentation/widgets/stats_tab.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Statistics'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Week'),
              Tab(text: 'Month'),
              Tab(text: 'Year'),
            ],
          ),
        ),
        body: Center(
          child: TabBarView(
            children: [
              StatsTab(type: BarChartType.week),
              StatsTab(type: BarChartType.month),
              StatsTab(type: BarChartType.year),
            ],
          ),
        ),
        bottomNavigationBar: Hero(
          tag: 'bottom_nav_bar',
          child: BottomNavBar(currentIndex: 2),
        ),
      ),
    );
  }
}
