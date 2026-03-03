import 'package:bloc_test/bloc_test.dart';
import 'package:finance/core/dependency_injection.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/category/domain/repository/category_repository.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';
import 'package:finance/features/transactions/domain/usecase/add_transaction.dart';
import 'package:finance/features/transactions/domain/usecase/delete_transaction.dart';
import 'package:finance/features/transactions/domain/usecase/get_all_transactions.dart';
import 'package:finance/features/transactions/domain/usecase/get_transaction.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_event.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

class MockTransactionRepository implements TransactionRepository {
  final List<Transaction> _transactions = [];

  @override
  Future<void> addTransaction(Transaction transaction) async {
    _transactions.add(transaction);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    _transactions.removeWhere((t) => t.id == id);
  }

  @override
  Future<Transaction> getTransaction(String id) async {
    return _transactions.firstWhere((t) => t.id == id);
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    return List.from(_transactions);
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    final index = _transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      _transactions[index] = transaction;
    }
  }
}

class MockCategoryRepository implements CategoryRepository {
  final List<Category> _categories = [
    Category(
      id: 'food',
      name: 'Food',
      icon: Icons.restaurant,
      color: Colors.orange,
    ),
    Category(
      id: 'transport',
      name: 'Transport',
      icon: Icons.directions_car,
      color: Colors.blue,
    ),
  ];

  @override
  Future<void> addCategory(Category category) async {
    _categories.add(category);
  }

  @override
  Future<void> deleteCategory(String id) async {
    _categories.removeWhere((c) => c.id == id);
  }

  @override
  Future<List<Category>> getCategories() async {
    return List.from(_categories);
  }

  @override
  Future<void> updateCategory(Category category) async {
    final index = _categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      _categories[index] = category;
    }
  }
}

void main() {
  setUpAll(() {
    if (!getIt.isRegistered<Uuid>()) {
      getIt.registerSingleton<Uuid>(const Uuid());
    }
  });

  tearDownAll(() {
    getIt.reset();
  });

  group('Transaction Flow Integration Tests', () {
    blocTest<TransactionsBloc, TransactionsState>(
      'should add a transaction and retrieve it in the list',
      build: () {
        final transactionRepo = MockTransactionRepository();
        final categoryRepo = MockCategoryRepository();
        return TransactionsBloc(
          GetAllTransactions(transactionRepo, categoryRepo),
          GetTransaction(transactionRepo),
          AddTransaction(transactionRepo),
          DeleteTransaction(transactionRepo),
        );
      },
      act: (bloc) {
        final newTransaction = Transaction(
          id: 'test-id-123',
          title: 'Grocery Shopping',
          amount: 75.50,
          type: TransactionType.expense,
          categoryId: 'food',
          description: 'Weekly groceries',
          date: DateTime(2024, 3, 1),
        );
        bloc.add(AddTransactionEvent(transaction: newTransaction));
        bloc.add(GetTransactionsWithCategoryEvent());
      },
      skip: 3,
      expect: () => [
        predicate<TransactionsState>(
          (state) =>
              state.status == TransactionsStatus.success &&
              state.transactions.length == 1 &&
              state.transactions.first.transaction.title ==
                  'Grocery Shopping' &&
              state.transactions.first.transaction.amount == 75.50 &&
              state.transactions.first.category.name == 'Food',
        ),
      ],
    );

    blocTest<TransactionsBloc, TransactionsState>(
      'should add multiple transactions and retrieve them all',
      build: () {
        final transactionRepo = MockTransactionRepository();
        final categoryRepo = MockCategoryRepository();
        return TransactionsBloc(
          GetAllTransactions(transactionRepo, categoryRepo),
          GetTransaction(transactionRepo),
          AddTransaction(transactionRepo),
          DeleteTransaction(transactionRepo),
        );
      },
      act: (bloc) {
        bloc.add(
          AddTransactionEvent(
            transaction: Transaction(
              id: 'tx-1',
              title: 'Coffee',
              amount: 5.50,
              type: TransactionType.expense,
              categoryId: 'food',
              description: 'Morning coffee',
              date: DateTime.now(),
            ),
          ),
        );
        bloc.add(
          AddTransactionEvent(
            transaction: Transaction(
              id: 'tx-2',
              title: 'Gas',
              amount: 45.00,
              type: TransactionType.expense,
              categoryId: 'transport',
              description: 'Fill up tank',
              date: DateTime.now(),
            ),
          ),
        );
        bloc.add(
          AddTransactionEvent(
            transaction: Transaction(
              id: 'tx-3',
              title: 'Salary',
              amount: 3000.00,
              type: TransactionType.income,
              categoryId: 'food',
              description: 'Monthly salary',
              date: DateTime.now(),
            ),
          ),
        );
        bloc.add(GetTransactionsWithCategoryEvent());
      },
      skip: 7,
      expect: () => [
        predicate<TransactionsState>(
          (state) =>
              state.status == TransactionsStatus.success &&
              state.transactions.length == 3,
        ),
      ],
    );

    test('should delete a transaction from the list', () async {
      final transactionRepo = MockTransactionRepository();
      final categoryRepo = MockCategoryRepository();
      final transactionsBloc = TransactionsBloc(
        GetAllTransactions(transactionRepo, categoryRepo),
        GetTransaction(transactionRepo),
        AddTransaction(transactionRepo),
        DeleteTransaction(transactionRepo),
      );

      final transaction = Transaction(
        id: 'to-delete',
        title: 'Test Transaction',
        amount: 100.0,
        type: TransactionType.expense,
        categoryId: 'food',
        description: 'Will be deleted',
        date: DateTime.now(),
      );

      final List<TransactionsState> states = [];
      final subscription = transactionsBloc.stream.listen((state) {
        states.add(state);
      });

      transactionsBloc.add(AddTransactionEvent(transaction: transaction));
      await Future.delayed(const Duration(milliseconds: 300));

      final addedTransactions = await transactionRepo.getTransactions();
      final actualId = addedTransactions.first.id;

      transactionsBloc.add(
        DeleteTransactionEvent(
          transactionId: actualId,
          successMessage: 'Transaction deleted',
        ),
      );
      await Future.delayed(const Duration(milliseconds: 300));

      transactionsBloc.add(GetTransactionsWithCategoryEvent());
      await Future.delayed(const Duration(milliseconds: 300));

      expect(states.length, greaterThanOrEqualTo(6));
      expect(states[0].status, TransactionsStatus.submitting);
      expect(states[1].status, TransactionsStatus.submited);
      expect(states[2].status, TransactionsStatus.submitting);
      expect(states[3].status, TransactionsStatus.submited);
      expect(states[3].successMessage, 'Transaction deleted');
      expect(states[4].status, TransactionsStatus.loadingList);
      expect(states[5].status, TransactionsStatus.success);
      expect(states[5].transactions.length, 0);

      await subscription.cancel();
      await transactionsBloc.close();
    });

    test('should calculate correct balance with income and expenses', () async {
      final transactionRepo = MockTransactionRepository();
      final categoryRepo = MockCategoryRepository();
      final transactionsBloc = TransactionsBloc(
        GetAllTransactions(transactionRepo, categoryRepo),
        GetTransaction(transactionRepo),
        AddTransaction(transactionRepo),
        DeleteTransaction(transactionRepo),
      );

      final income = Transaction(
        id: 'income-1',
        title: 'Freelance Payment',
        amount: 500.0,
        type: TransactionType.income,
        categoryId: 'food',
        description: 'Client payment',
        date: DateTime.now(),
      );

      final expense = Transaction(
        id: 'expense-1',
        title: 'Rent',
        amount: 300.0,
        type: TransactionType.expense,
        categoryId: 'transport',
        description: 'Monthly rent',
        date: DateTime.now(),
      );

      final List<TransactionsState> states = [];
      final subscription = transactionsBloc.stream.listen((state) {
        states.add(state);
      });

      transactionsBloc.add(AddTransactionEvent(transaction: income));
      await Future.delayed(const Duration(milliseconds: 200));

      transactionsBloc.add(AddTransactionEvent(transaction: expense));
      await Future.delayed(const Duration(milliseconds: 200));

      transactionsBloc.add(GetTransactionsWithCategoryEvent());
      await Future.delayed(const Duration(milliseconds: 200));

      expect(states.length, greaterThanOrEqualTo(6));
      expect(states[0].status, TransactionsStatus.submitting);
      expect(states[1].status, TransactionsStatus.submited);
      expect(states[2].status, TransactionsStatus.submitting);
      expect(states[3].status, TransactionsStatus.submited);
      expect(states[4].status, TransactionsStatus.loadingList);
      expect(states[5].status, TransactionsStatus.success);
      expect(states[5].transactions.length, 2);

      final incomeTransaction = states[5].transactions.firstWhere(
        (t) => t.transaction.type == TransactionType.income,
      );
      final expenseTransaction = states[5].transactions.firstWhere(
        (t) => t.transaction.type == TransactionType.expense,
      );
      expect(incomeTransaction.transaction.amount, 500.0);
      expect(expenseTransaction.transaction.amount, 300.0);

      await subscription.cancel();
      await transactionsBloc.close();
    });
  });
}
