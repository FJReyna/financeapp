import 'package:finance/core/util/extensions.dart';
import 'package:finance/features/transactions/presentation/widgets/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(context.translate.addTransactionTitle),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(FontAwesomeIcons.chevronLeft),
        ),
      ),
      body: Center(child: TransactionForm()),
    );
  }
}
