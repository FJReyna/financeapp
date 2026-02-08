import 'package:finance/core/widgets/bottom_nav_bar.dart';
import 'package:finance/features/transactions/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: const [
            Text('Today'),
            TransactionCard(),
            TransactionCard(),
            Text('Yesterday'),
            TransactionCard(),
            TransactionCard(),
            TransactionCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(FontAwesomeIcons.plus),
      ),
      bottomNavigationBar: Hero(
        tag: 'bottom_nav_bar',
        child: BottomNavBar(currentIndex: 1),
      ),
    );
  }
}
