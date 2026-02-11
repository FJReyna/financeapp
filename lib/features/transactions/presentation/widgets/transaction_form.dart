import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/presentation/widgets/add_transaction/category_selector.dart';
import 'package:finance/features/transactions/presentation/widgets/add_transaction/transaction_date_picker.dart';
import 'package:finance/features/transactions/presentation/widgets/add_transaction/transaction_type_switch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  TransactionType _transactionType = TransactionType.income;
  String categorySelectedId = '';
  DateTime selectedDate = DateTime.now();

  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: '');
    _amountController = TextEditingController(text: '00.00');
    _descriptionController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TransactionTypeSwitch(
              transactionType: _transactionType,
              onChanged: (type) {
                setState(() {
                  _transactionType = type;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _titleController,
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                prefixIcon: Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.primary.withAlpha(50),
                  ),
                  child: Icon(
                    FontAwesomeIcons.pen,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                fillColor: Theme.of(context).cardTheme.color,
                filled: true,
                hintText: 'Add a title',
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'AMOUNT',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,

              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixText: '\$',
                fillColor: Theme.of(context).cardTheme.color,
                filled: true,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          CategorySelector(
            selectedCategoryId: categorySelectedId,
            onCategorySelected: (id) {
              setState(() {
                categorySelectedId = id;
              });
            },
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TransactionDatePicker(
              onDateSelected: (date) {
                selectedDate = date;
              },
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _descriptionController,
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                prefixIcon: Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(20),
                  ),
                  child: Icon(
                    FontAwesomeIcons.pen,
                    size: 16,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(100),
                  ),
                ),
                fillColor: Theme.of(context).cardTheme.color,
                filled: true,
                hintText: 'Add a description (Optional)',
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.floppyDisk),
              label: Text('Save'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
