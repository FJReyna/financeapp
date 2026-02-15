import 'package:finance/core/constants/hero_tags.dart';
import 'package:finance/core/util/extensions.dart';
import 'package:finance/core/widgets/bottom_nav_bar.dart';
import 'package:finance/features/dashboard/presentation/widgets/monthly_trend.dart';
import 'package:finance/features/dashboard/presentation/widgets/spending_breakdown_card.dart';
import 'package:finance/features/dashboard/presentation/widgets/today_card.dart';
import 'package:finance/features/dashboard/presentation/widgets/top_expense_card.dart';
import 'package:finance/features/dashboard/presentation/widgets/total_balance_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(context.translate.dashboardWelcomeTitle),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.bell)),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 16),
            TotalBalanceCard(),
            SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.translate.dashboardQuickSummary,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: TodayCard()),
                SizedBox(width: 16),
                Expanded(child: TopExpenseCard()),
              ],
            ),
            SizedBox(height: 32),
            SpendingBreakdownCard(),
            SizedBox(height: 32),
            MonthlyTrend(),
          ],
        ),
      ),
      bottomNavigationBar: Hero(
        tag: HeroTags.bottomNavBar,
        child: BottomNavBar(currentIndex: 0),
      ),
    );
  }
}
