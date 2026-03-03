import 'package:finance/core/util/extensions.dart';
import 'package:finance/features/dashboard/domain/entities/today_summary_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TodayCard extends StatelessWidget {
  final TodaySummaryData data;

  const TodayCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(FontAwesomeIcons.calendar, size: 20, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  context.translate.today,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${data.balance < 0 ? '-' : ''}\$${data.balance.abs().toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '${data.transactionCount} transactions',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
