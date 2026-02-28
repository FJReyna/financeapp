import 'package:finance/core/theme/app_colors.dart';
import 'package:finance/features/stats/domain/entities/bar_chart_point.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

enum BarChartType { week, month, year }

class BarCharStats extends StatefulWidget {
  final BarChartType type;
  final List<BarChartPoint> chartData;

  const BarCharStats({
    super.key,
    required this.type,
    this.chartData = const [],
  });

  @override
  State<BarCharStats> createState() => _BarCharStatsState();
}

class _BarCharStatsState extends State<BarCharStats> {
  int touchedGroupIndex = -1;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void didUpdateWidget(BarCharStats oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.chartData != widget.chartData ||
        oldWidget.type != widget.type) {
      _initData();
    }
  }

  void _initData() {
    if (widget.chartData.isEmpty) {
      rawBarGroups = [];
      showingBarGroups = [];
      return;
    }

    rawBarGroups = widget.chartData.map((point) {
      return _makeGroupData(point.index, point.income, point.expense);
    }).toList();

    showingBarGroups = rawBarGroups;
  }

  double get _barWidth {
    switch (widget.type) {
      case BarChartType.week:
        return 7.0;
      case BarChartType.month:
        return 5.0;
      case BarChartType.year:
        return 12.0;
    }
  }

  double get _maxY {
    if (widget.chartData.isEmpty) return 20.0;

    final maxValue = widget.chartData.fold<double>(0.0, (max, point) {
      final pointMax = point.income > point.expense
          ? point.income
          : point.expense;
      return pointMax > max ? pointMax : max;
    });

    return ((maxValue / 1000).ceil() * 1000).toDouble();
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    final double interval = _maxY / 3;
    String text;

    if (value == 0) {
      text = '0';
    } else if ((value - interval).abs() < 0.1) {
      text = '\$${(interval / 1000).toStringAsFixed(0)}K';
    } else if ((value - interval * 2).abs() < 0.1) {
      text = '\$${(interval * 2 / 1000).toStringAsFixed(0)}K';
    } else if ((value - _maxY).abs() < 0.1) {
      text = '\$${(_maxY / 1000).toStringAsFixed(0)}K';
    } else {
      return Container();
    }

    return SideTitleWidget(
      meta: meta,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta, BarChartType type) {
    if (widget.chartData.isEmpty || value.toInt() >= widget.chartData.length) {
      return const SizedBox.shrink();
    }

    final label = widget.chartData[value.toInt()].label;

    final Widget text = Text(
      label,
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(meta: meta, space: 16, child: text);
  }

  BarChartGroupData _makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 1,
      x: x,
      barRods: [
        BarChartRodData(toY: y1, color: AppColors.primary, width: _barWidth),
        BarChartRodData(toY: y2, color: AppColors.secondary, width: _barWidth),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chartData.isEmpty) {
      return SizedBox(
        height: 400,
        child: Card(
          margin: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              'No data available',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 400,
      child: Card(
        margin: const EdgeInsets.all(8),
        child: BarChart(
          BarChartData(
            maxY: _maxY,
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) =>
                      bottomTitles(value, meta, widget.type),
                  reservedSize: 42,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: _maxY / 3,
                  getTitlesWidget: (value, meta) => leftTitles(value, meta),
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: showingBarGroups,
            gridData: const FlGridData(show: false),
          ),
        ),
      ),
    );
  }
}
