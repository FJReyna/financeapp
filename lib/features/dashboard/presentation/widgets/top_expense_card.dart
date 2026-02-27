import 'package:finance/core/theme/app_colors.dart';
import 'package:finance/core/util/extensions.dart';
import 'package:finance/features/dashboard/domain/entities/top_expense_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopExpenseCard extends StatelessWidget {
  final TopExpenseData data;

  const TopExpenseCard({super.key, required this.data});

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
                Expanded(
                  child: Text(
                    context.translate.topExpense,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '-\$${data.transaction.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              data.transaction.title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
