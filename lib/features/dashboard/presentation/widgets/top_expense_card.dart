import 'package:finance/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopExpenseCard extends StatelessWidget {
  const TopExpenseCard({super.key});

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
                Icon(
                  FontAwesomeIcons.triangleExclamation,
                  size: 20,
                  color: AppColors.secondary,
                ),
                SizedBox(width: 8),
                Text(
                  'Top Expense',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '-\$120.00',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text('Monthly rent', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
