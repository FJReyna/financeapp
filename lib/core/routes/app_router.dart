import 'package:finance/core/routes/routes.dart';
import 'package:finance/features/category/presentation/pages/add_category_page.dart';
import 'package:finance/features/dashboard/presentation/pages/dashboard.dart';
import 'package:finance/features/settings/presentation/pages/settings_page.dart';
import 'package:finance/features/stats/presentation/pages/statistics_page.dart';
import 'package:finance/features/transactions/presentation/pages/transaction_page.dart';
import 'package:finance/features/transactions/presentation/pages/transactions_page.dart';
import 'package:finance/features/transactions/presentation/pages/add_transaction_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.dashboard,
  routes: [
    GoRoute(
      path: Routes.dashboard,
      builder: (context, state) => const Dashboard(),
    ),
    GoRoute(
      path: Routes.transactions,
      builder: (context, state) => const TransactionsPage(),
    ),
    GoRoute(
      path: Routes.addTransaction,
      builder: (context, state) => const AddTransactionPage(),
    ),
    GoRoute(
      path: '${Routes.transaction}/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return TransactionPage(transactionId: id);
      },
    ),
    GoRoute(
      path: Routes.stats,
      builder: (context, state) => const StatisticsPage(),
    ),
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: Routes.addCategory,
      builder: (context, state) => const AddCategoryPage(),
    ),
  ],
);
