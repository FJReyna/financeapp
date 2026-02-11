import 'package:finance/core/dependency_injection.dart';
import 'package:finance/core/util/validators.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_event.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_state.dart';
import 'package:finance/features/transactions/presentation/widgets/add_transaction/category_selector.dart';
import 'package:finance/features/transactions/presentation/widgets/add_transaction/transaction_date_picker.dart';
import 'package:finance/features/transactions/presentation/widgets/add_transaction/transaction_type_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return BlocProvider(
      create: (context) => getIt<TransactionsBloc>(),
      child: BlocListener<TransactionsBloc, TransactionsState>(
        listener: (context, state) {
          if (state.status == TransactionsStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'An error occurred'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          } else if (state.status == TransactionsStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Transaction added successfully!'),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
            Navigator.pop(context);
          }
        },
        child: Form(
          key: _formKey,
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
                  validator: (value) => Validators.validateNotEmpty(value),
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(50),
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
                  validator: (value) => Validators.validateAmount(value),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
                child: BlocBuilder<TransactionsBloc, TransactionsState>(
                  builder: (context, state) {
                    return state.status == TransactionsStatus.submitting
                        ? CircularProgressIndicator()
                        : ElevatedButton.icon(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<TransactionsBloc>().add(
                                  AddTransactionEvent(
                                    transaction: Transaction(
                                      id: '',
                                      title: _titleController.text.trim(),
                                      amount: double.parse(
                                        _amountController.text,
                                      ),
                                      type: _transactionType,
                                      categoryId: categorySelectedId,
                                      description: _descriptionController.text
                                          .trim(),
                                      date: selectedDate,
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: Icon(FontAwesomeIcons.floppyDisk),
                            label: Text('Save'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              foregroundColor: Theme.of(
                                context,
                              ).colorScheme.onPrimary,
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
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
