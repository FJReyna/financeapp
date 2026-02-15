import 'package:finance/core/util/extensions.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/entities/transaction_with_category.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionCard extends StatelessWidget {
  final TransactionWithCategory transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(transaction.transaction.id),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(context.translate.transactionsDeleteTitle),
            content: Text(context.translate.transactionsDeleteMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(context.translate.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  context.translate.delete,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        context.read<TransactionsBloc>().add(
          DeleteTransactionEvent(
            transactionId: transaction.transaction.id,
            successMessage: context.translate.transactionsDeleteSuccess,
          ),
        );
      },
      direction: DismissDirection.endToStart,
      dismissThresholds: {DismissDirection.endToStart: 0.75},
      movementDuration: Duration(milliseconds: 500),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(FontAwesomeIcons.trash, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: transaction.category.color.withAlpha(50),
            child: Icon(
              transaction.category.icon,
              color: transaction.category.color,
            ),
          ),
          title: Text(transaction.transaction.title),
          subtitle: Text(transaction.category.localizedName(context)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${transaction.transaction.type == TransactionType.expense ? '-' : '+'} \$${transaction.transaction.amount}',
                style: TextStyle(
                  color: transaction.transaction.type == TransactionType.expense
                      ? Colors.red
                      : Colors.green,
                ),
              ),
              Text('${transaction.transaction.date.toLocal()}'.split(' ')[0]),
            ],
          ),
        ),
      ),
    );
  }
}
