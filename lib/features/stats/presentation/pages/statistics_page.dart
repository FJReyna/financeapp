import 'package:finance/core/constants/hero_tags.dart';
import 'package:finance/core/util/extensions.dart';
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
          title: Text(context.translate.statisticsTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: context.translate.week),
              Tab(text: context.translate.month),
              Tab(text: context.translate.year),
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
          tag: HeroTags.bottomNavBar,
          child: BottomNavBar(currentIndex: 2),
        ),
      ),
    );
  }
}
