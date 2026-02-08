import 'package:finance/features/dashboard/presentation/widgets/category_breakdown_linear_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SpendingBreakdownCard extends StatelessWidget {
  const SpendingBreakdownCard({super.key});

  final double chartHeight = 300.0;
  final double sectionRadius = 20.0;

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
              'Spending Breakdown',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: chartHeight,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          showTitle: false,
                          value: 40,
                          color: Colors.green,
                          title: 'Food',
                          radius: sectionRadius,
                          titleStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          value: 30,
                          color: Colors.red,
                          title: 'Transport',
                          radius: sectionRadius,
                          titleStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          value: 20,
                          color: Colors.blue,
                          title: 'Entertainment',
                          radius: sectionRadius,
                          titleStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          value: 10,
                          color: Colors.orange,
                          title: 'Other',
                          radius: sectionRadius,
                          titleStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      centerSpaceRadius: chartHeight / 4,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          '\$1,150.00',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            CategoryBreakdownLinearIndicator(
              color: Colors.green,
              value: 0.4,
              title: 'Food',
              icon: Icons.fastfood,
            ),
            SizedBox(height: 8),
            CategoryBreakdownLinearIndicator(
              color: Colors.red,
              value: 0.3,
              title: 'Transport',
              icon: Icons.directions_car,
            ),
            SizedBox(height: 8),
            CategoryBreakdownLinearIndicator(
              color: Colors.blue,
              value: 0.2,
              title: 'Entertainment',
              icon: Icons.movie,
            ),
            SizedBox(height: 8),
            CategoryBreakdownLinearIndicator(
              color: Colors.orange,
              value: 0.1,
              title: 'Other',
              icon: Icons.more_horiz,
            ),
          ],
        ),
      ),
    );
  }
}
