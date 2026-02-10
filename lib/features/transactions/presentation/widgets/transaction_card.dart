import 'package:finance/features/transactions/domain/entitites/transaction.dart';
import 'package:finance/features/transactions/domain/entitites/transaction_with_category.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final TransactionWithCategory transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
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
        subtitle: Text(transaction.category.name),
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
    );
  }
}
