import 'package:finance/core/util/extensions.dart';
import 'package:finance/features/dashboard/domain/entities/category_spending.dart';
import 'package:finance/features/dashboard/presentation/widgets/category_breakdown_linear_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SpendingBreakdownCard extends StatelessWidget {
  final List<CategorySpending> spendingByCategory;

  SpendingBreakdownCard({super.key, required this.spendingByCategory});

  final double chartHeight = 300.0;
  final double sectionRadius = 20.0;

  final TextStyle sectionTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
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
              context.translate.dashboardSpendingBreakdown,
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
                      sections: spendingByCategory.map((data) {
                        return PieChartSectionData(
                          showTitle: false,
                          value: data.percentage,
                          color: data.category.color,
                          title: data.category.name,
                          radius: sectionRadius,
                          titleStyle: sectionTextStyle,
                        );
                      }).toList(),
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
                          '\$${spendingByCategory.fold(0.0, (sum, data) => sum + data.amount).toStringAsFixed(2)}',
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
            Column(
              children: spendingByCategory.map((data) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: CategoryBreakdownLinearIndicator(
                    value: data.percentage,
                    title: data.category.name,
                    color: data.category.color,
                    icon: data.category.icon,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
