import 'package:finance/core/theme/app_colors.dart';
import 'package:finance/core/util/extensions.dart';
import 'package:finance/features/dashboard/domain/entities/trend_point.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyTrend extends StatelessWidget {
  final List<TrendPoint> trendPoints;

  const MonthlyTrend(this.trendPoints, {super.key});

  LineChartData get sampleData {
    final double maxIncome = trendPoints.isEmpty
        ? 1000.0
        : trendPoints
              .map((TrendPoint point) => point.income)
              .reduce((a, b) => a > b ? a : b);
    final double maxExpense = trendPoints.isEmpty
        ? 1000.0
        : trendPoints
              .map((TrendPoint point) => point.expense)
              .reduce((a, b) => a > b ? a : b);
    final double maxY = (maxIncome > maxExpense ? maxIncome : maxExpense) * 1.2;

    final double maxX = trendPoints.isEmpty
        ? 28.0
        : trendPoints
              .map((TrendPoint point) => point.x)
              .reduce((a, b) => a > b ? a : b);

    return LineChartData(
      lineTouchData: lineTouchData1,
      gridData: gridData,
      titlesData: titlesData1,
      borderData: borderData,
      lineBarsData: lineBarsData1,
      minX: 0,
      maxX: maxX + 7,
      maxY: maxY,
      minY: 0,
    );
  }

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
    lineChartBarData1_2,
  ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: true,
    preventCurveOverShooting: true,
    color: Colors.green,
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: true),
    belowBarData: BarAreaData(show: false),
    spots: trendPoints
        .map((TrendPoint point) => FlSpot(point.x, point.income))
        .toList(),
  );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
    isCurved: true,
    preventCurveOverShooting: true,
    color: Colors.pink,
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: true),
    belowBarData: BarAreaData(show: false),
    spots: trendPoints
        .map((TrendPoint point) => FlSpot(point.x, point.expense))
        .toList(),
  );

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      getTooltipColor: (touchedSpot) => Colors.blueGrey.withValues(alpha: 0.8),
      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
        return touchedBarSpots.map((barSpot) {
          final weekNumber = (barSpot.x / 7).round();
          final flSpot = barSpot;
          final isIncome = flSpot.barIndex == 0;

          return LineTooltipItem(
            '${isIncome ? 'Income' : 'Expense'}: \$${flSpot.y.toStringAsFixed(2)}\nW$weekNumber',
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          );
        }).toList();
      },
    ),
  );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom: BorderSide(
        color: AppColors.primary.withValues(alpha: 0.2),
        width: 4,
      ),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(sideTitles: bottomTitles),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    leftTitles: AxisTitles(sideTitles: leftTitles()),
  );

  SideTitles leftTitles() =>
      SideTitles(showTitles: true, interval: 1, reservedSize: 0);

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    final weekNumber = (value / 7).round();

    String text = switch (weekNumber) {
      1 => 'W1',
      2 => 'W2',
      3 => 'W3',
      4 => 'W4',
      _ => '',
    };

    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: Text(text, style: style),
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 7,
    getTitlesWidget: bottomTitleWidgets,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.translate.dashboardMonthlyTrend,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(height: 200, child: Center(child: LineChart(sampleData))),
          ],
        ),
      ),
    );
  }
}
