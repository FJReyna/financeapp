import 'package:finance/core/theme/app_colors.dart';
import 'package:finance/core/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TotalBalanceCard extends StatelessWidget {
  const TotalBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.translate.dashboardTotalBlance,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '\$14,250.00',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.circleArrowUp,
                          color: AppColors.primary,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          context.translate.income,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '+\$5,000.00',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Theme.of(context).dividerColor,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.circleArrowDown,
                          color: AppColors.secondary,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          context.translate.expenses,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '-\$2,750.00',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
