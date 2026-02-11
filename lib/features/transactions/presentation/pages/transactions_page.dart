import 'package:finance/core/dependency_injection.dart';
import 'package:finance/core/routes/routes.dart';
import 'package:finance/core/widgets/bottom_nav_bar.dart';
import 'package:finance/features/transactions/domain/entities/transaction_with_category.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_event.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_state.dart';
import 'package:finance/features/transactions/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  Map<String, List<TransactionWithCategory>> _groupTransactionsByDate(
    List<TransactionWithCategory> transactions,
  ) {
    final grouped = <String, List<TransactionWithCategory>>{};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (var transaction in transactions) {
      final transactionDate = DateTime(
        transaction.transaction.date.year,
        transaction.transaction.date.month,
        transaction.transaction.date.day,
      );

      String key;
      if (transactionDate == today) {
        key = 'Today';
      } else if (transactionDate == yesterday) {
        key = 'Yesterday';
      } else {
        key = DateFormat('MMMM dd, yyyy').format(transactionDate);
      }

      grouped.putIfAbsent(key, () => []).add(transaction);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionsBloc>(
      create: (context) =>
          getIt<TransactionsBloc>()..add(GetTransactionsWithCategoryEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Transactions')),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<TransactionsBloc, TransactionsState>(
            builder: (context, state) {
              if (state.status == TransactionsStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == TransactionsStatus.failure) {
                return Center(child: Text(state.errorMessage ?? 'Error'));
              } else if (state.status == TransactionsStatus.success) {
                if (state.transactions.isEmpty) {
                  return const Center(child: Text('No transactions found'));
                }
                final groupedTransactions = _groupTransactionsByDate(
                  state.transactions,
                );
                return ListView.builder(
                  itemCount: groupedTransactions.length,
                  itemBuilder: (context, index) {
                    final entry = groupedTransactions.entries.elementAt(index);
                    final dateLabel = entry.key;
                    final transactions = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            dateLabel,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...transactions.map(
                          (transaction) =>
                              TransactionCard(transaction: transaction),
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(addTransactionRoute);
          },
          child: const Icon(FontAwesomeIcons.plus),
        ),
        bottomNavigationBar: Hero(
          tag: 'bottom_nav_bar',
          child: BottomNavBar(currentIndex: 1),
        ),
      ),
    );
  }
}
