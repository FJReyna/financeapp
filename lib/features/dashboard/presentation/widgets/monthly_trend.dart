import 'package:finance/core/theme/app_colors.dart';
import 'package:finance/core/util/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyTrend extends StatelessWidget {
  const MonthlyTrend({super.key});

  LineChartData get sampleData => LineChartData(
    lineTouchData: lineTouchData1,
    gridData: gridData,
    titlesData: titlesData1,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 1,
    maxX: 28,
    maxY: 4,
    minY: 0,
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
    lineChartBarData1_2,
  ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: true,
    color: Colors.green,
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(1, 1),
      FlSpot(7, 2.5),
      FlSpot(14, 2.7),
      FlSpot(21, 2.4),
      FlSpot(28, 2.6),
    ],
  );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
    isCurved: true,
    color: Colors.pink,
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(show: false, color: Colors.pink),
    spots: const [
      FlSpot(1, 0.8),
      FlSpot(7, 1.8),
      FlSpot(14, 1.2),
      FlSpot(21, 1.8),
      FlSpot(28, 1.8),
    ],
  );

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      getTooltipColor: (touchedSpot) => Colors.blueGrey.withValues(alpha: 0.8),
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
    String text = switch (value.toInt()) {
      7 => 'W1',
      14 => 'W2',
      21 => 'W3',
      28 => 'W4',
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
    interval: 1,
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
