import 'package:finance/core/dependency_injection.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_event.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionPage extends StatefulWidget {
  final String transactionId;

  const TransactionPage({super.key, required this.transactionId});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    super.initState();
    getIt<TransactionsBloc>().add(
      GetTransactionEvent(transactionId: widget.transactionId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionsBloc>.value(
      value: getIt<TransactionsBloc>(),
      child: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.transaction?.title ?? 'Transaction'),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(FontAwesomeIcons.chevronLeft),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount: \$${state.transaction?.amount.toStringAsFixed(2) ?? '0.00'}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Date: ${state.transaction?.date.toLocal().toString().split(' ')[0] ?? ''}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description: ${state.transaction?.description ?? ''}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
