import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.shopping_cart)),
        title: const Text('Grocery Store'),
        subtitle: const Text('Groceries'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('-\$45.67', style: TextStyle(color: Colors.red)),
            const Text('Sep 20, 2024'),
          ],
        ),
      ),
    );
  }
}
