import 'package:finance/core/routes/routes.dart';
import 'package:finance/features/dashboard/presentation/pages/dashboard.dart';
import 'package:finance/features/settings/presentation/pages/settings_page.dart';
import 'package:finance/features/stats/presentation/pages/statistics_page.dart';
import 'package:finance/features/transactions/presentation/pages/transactions_page.dart';
import 'package:finance/features/transactions/presentation/pages/add_transaction_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: dashboardRoute,
  routes: [
    GoRoute(
      path: dashboardRoute,
      builder: (context, state) => const Dashboard(),
    ),
    GoRoute(
      path: transactionsRoute,
      builder: (context, state) => const TransactionsPage(),
    ),
    GoRoute(
      path: addTransactionRoute,
      builder: (context, state) => const AddTransactionPage(),
    ),
    GoRoute(
      path: statsRoute,
      builder: (context, state) => const StatisticsPage(),
    ),
    GoRoute(
      path: settingsRoute,
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
