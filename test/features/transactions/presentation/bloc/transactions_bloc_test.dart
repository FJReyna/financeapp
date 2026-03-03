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
  final Exception? exception;

  MockTransactionRepository({this.exception, List<Transaction>? initial}) {
    if (initial != null) _transactions.addAll(initial);
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    if (exception != null) throw exception!;
    _transactions.add(transaction);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    if (exception != null) throw exception!;
    _transactions.removeWhere((t) => t.id == id);
  }

  @override
  Future<Transaction> getTransaction(String id) async {
    if (exception != null) throw exception!;
    return _transactions.firstWhere((t) => t.id == id);
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    if (exception != null) throw exception!;
    return _transactions;
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    if (exception != null) throw exception!;
  }
}

class MockCategoryRepository implements CategoryRepository {
  @override
  Future<void> addCategory(Category category) async {}

  @override
  Future<void> deleteCategory(String id) async {}

  @override
  Future<List<Category>> getCategories() async {
    return [
      Category(
        id: 'cat1',
        name: 'Food',
        icon: Icons.restaurant,
        color: Colors.orange,
      ),
    ];
  }

  @override
  Future<void> updateCategory(Category category) async {}
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

  group('TransactionsBloc Tests', () {
    late Transaction testTransactionEntity;

    setUp(() {
      testTransactionEntity = Transaction(
        id: '1',
        title: 'Test Transaction',
        amount: 100.0,
        type: TransactionType.expense,
        categoryId: 'cat1',
        description: 'Test description',
        date: DateTime(2024, 2, 15),
      );
    });

    blocTest<TransactionsBloc, TransactionsState>(
      'GetTransactionsWithCategoryEvent emits [loadingList, success] when successful',
      build: () {
        final transactionRepo = MockTransactionRepository(
          initial: [testTransactionEntity],
        );
        final categoryRepo = MockCategoryRepository();
        return TransactionsBloc(
          GetAllTransactions(transactionRepo, categoryRepo),
          GetTransaction(transactionRepo),
          AddTransaction(transactionRepo),
          DeleteTransaction(transactionRepo),
        );
      },
      act: (bloc) => bloc.add(GetTransactionsWithCategoryEvent()),
      expect: () => [
        predicate<TransactionsState>(
          (state) => state.status == TransactionsStatus.loadingList,
        ),
        predicate<TransactionsState>(
          (state) =>
              state.status == TransactionsStatus.success &&
              state.transactions.length == 1 &&
              state.transactions.first.transaction.id == '1',
        ),
      ],
    );

    blocTest<TransactionsBloc, TransactionsState>(
      'GetTransactionsWithCategoryEvent emits [loadingList, failure] when error occurs',
      build: () {
        final transactionRepo = MockTransactionRepository(
          exception: Exception('Failed to load transactions'),
        );
        final categoryRepo = MockCategoryRepository();
        return TransactionsBloc(
          GetAllTransactions(transactionRepo, categoryRepo),
          GetTransaction(transactionRepo),
          AddTransaction(transactionRepo),
          DeleteTransaction(transactionRepo),
        );
      },
      act: (bloc) => bloc.add(GetTransactionsWithCategoryEvent()),
      expect: () => [
        predicate<TransactionsState>(
          (state) => state.status == TransactionsStatus.loadingList,
        ),
        predicate<TransactionsState>(
          (state) =>
              state.status == TransactionsStatus.failure &&
              state.errorMessage != null,
        ),
      ],
    );

    blocTest<TransactionsBloc, TransactionsState>(
      'AddTransactionEvent emits [submitting, submited] when successful',
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
      act: (bloc) =>
          bloc.add(AddTransactionEvent(transaction: testTransactionEntity)),
      expect: () => [
        predicate<TransactionsState>(
          (state) => state.status == TransactionsStatus.submitting,
        ),
        predicate<TransactionsState>(
          (state) => state.status == TransactionsStatus.submited,
        ),
      ],
    );

    blocTest<TransactionsBloc, TransactionsState>(
      'AddTransactionEvent emits [submitting, failure] when error occurs',
      build: () {
        final transactionRepo = MockTransactionRepository(
          exception: Exception('Failed to add transaction'),
        );
        final categoryRepo = MockCategoryRepository();
        return TransactionsBloc(
          GetAllTransactions(transactionRepo, categoryRepo),
          GetTransaction(transactionRepo),
          AddTransaction(transactionRepo),
          DeleteTransaction(transactionRepo),
        );
      },
      act: (bloc) =>
          bloc.add(AddTransactionEvent(transaction: testTransactionEntity)),
      expect: () => [
        predicate<TransactionsState>(
          (state) => state.status == TransactionsStatus.submitting,
        ),
        predicate<TransactionsState>(
          (state) =>
              state.status == TransactionsStatus.failure &&
              state.errorMessage != null,
        ),
      ],
    );

    blocTest<TransactionsBloc, TransactionsState>(
      'DeleteTransactionEvent emits [submitting, submited] when successful',
      build: () {
        final transactionRepo = MockTransactionRepository(
          initial: [testTransactionEntity],
        );
        final categoryRepo = MockCategoryRepository();
        return TransactionsBloc(
          GetAllTransactions(transactionRepo, categoryRepo),
          GetTransaction(transactionRepo),
          AddTransaction(transactionRepo),
          DeleteTransaction(transactionRepo),
        );
      },
      act: (bloc) => bloc.add(
        DeleteTransactionEvent(
          transactionId: '1',
          successMessage: 'Deleted successfully',
        ),
      ),
      expect: () => [
        predicate<TransactionsState>(
          (state) => state.status == TransactionsStatus.submitting,
        ),
        predicate<TransactionsState>(
          (state) =>
              state.status == TransactionsStatus.submited &&
              state.successMessage == 'Deleted successfully',
        ),
      ],
    );

    blocTest<TransactionsBloc, TransactionsState>(
      'DeleteTransactionEvent emits [submitting, failure] when error occurs',
      build: () {
        final transactionRepo = MockTransactionRepository(
          exception: Exception('Failed to delete'),
        );
        final categoryRepo = MockCategoryRepository();
        return TransactionsBloc(
          GetAllTransactions(transactionRepo, categoryRepo),
          GetTransaction(transactionRepo),
          AddTransaction(transactionRepo),
          DeleteTransaction(transactionRepo),
        );
      },
      act: (bloc) => bloc.add(
        DeleteTransactionEvent(
          transactionId: '1',
          successMessage: 'Deleted successfully',
        ),
      ),
      expect: () => [
        predicate<TransactionsState>(
          (state) => state.status == TransactionsStatus.submitting,
        ),
        predicate<TransactionsState>(
          (state) =>
              state.status == TransactionsStatus.failure &&
              state.errorMessage != null,
        ),
      ],
    );

    blocTest<TransactionsBloc, TransactionsState>(
      'GetTransactionEvent emits [loading, success] when successful',
      build: () {
        final transactionRepo = MockTransactionRepository(
          initial: [testTransactionEntity],
        );
        final categoryRepo = MockCategoryRepository();
        return TransactionsBloc(
          GetAllTransactions(transactionRepo, categoryRepo),
          GetTransaction(transactionRepo),
          AddTransaction(transactionRepo),
          DeleteTransaction(transactionRepo),
        );
      },
      act: (bloc) => bloc.add(GetTransactionEvent(transactionId: '1')),
      wait: const Duration(seconds: 4),
      expect: () => [
        predicate<TransactionsState>(
          (state) => state.status == TransactionsStatus.loading,
        ),
        predicate<TransactionsState>(
          (state) =>
              state.status == TransactionsStatus.success &&
              state.transaction?.id == '1',
        ),
      ],
    );

    blocTest<TransactionsBloc, TransactionsState>(
      'GetTransactionEvent emits [loading, failure] when error occurs',
      build: () {
        final transactionRepo = MockTransactionRepository(
          exception: Exception('Transaction not found'),
        );
        final categoryRepo = MockCategoryRepository();
        return TransactionsBloc(
          GetAllTransactions(transactionRepo, categoryRepo),
          GetTransaction(transactionRepo),
          AddTransaction(transactionRepo),
          DeleteTransaction(transactionRepo),
        );
      },
      act: (bloc) => bloc.add(GetTransactionEvent(transactionId: '1')),
      wait: const Duration(seconds: 4),
      expect: () => [
        predicate<TransactionsState>(
          (state) => state.status == TransactionsStatus.loading,
        ),
        predicate<TransactionsState>(
          (state) =>
              state.status == TransactionsStatus.failure &&
              state.errorMessage != null,
        ),
      ],
    );
  });
}
