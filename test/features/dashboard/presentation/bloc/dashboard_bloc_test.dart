import 'package:bloc_test/bloc_test.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/category/domain/repository/category_repository.dart';
import 'package:finance/features/dashboard/domain/usecases/get_dashboard_data.dart';
import 'package:finance/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:finance/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:finance/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTransactionRepository implements TransactionRepository {
  final List<Transaction> _transactions;
  final Exception? exception;

  MockTransactionRepository({this.exception, List<Transaction>? initial})
    : _transactions = initial ?? [];

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
  final List<Category> _categories;

  MockCategoryRepository({List<Category>? initial})
    : _categories = initial ?? [];

  @override
  Future<void> addCategory(Category category) async {}

  @override
  Future<void> deleteCategory(String id) async {}

  @override
  Future<List<Category>> getCategories() async {
    return _categories;
  }

  @override
  Future<void> updateCategory(Category category) async {}
}

void main() {
  group('DashboardBloc Tests', () {
    late Category testCategory;
    late Transaction testExpenseTransaction;
    late Transaction testIncomeTransaction;
    late List<Transaction> testTransactions;

    setUp(() {
      testCategory = Category(
        id: 'cat1',
        name: 'Food',
        icon: Icons.restaurant,
        color: Colors.orange,
      );

      testExpenseTransaction = Transaction(
        id: '1',
        title: 'Groceries',
        amount: 150.0,
        type: TransactionType.expense,
        categoryId: 'cat1',
        description: 'Weekly shopping',
        date: DateTime.now(),
      );

      testIncomeTransaction = Transaction(
        id: '2',
        title: 'Salary',
        amount: 2650.0,
        type: TransactionType.income,
        categoryId: 'cat1',
        description: 'Monthly salary',
        date: DateTime.now(),
      );

      testTransactions = [testExpenseTransaction, testIncomeTransaction];
    });

    blocTest<DashboardBloc, DashboardState>(
      'initial state is correct',
      build: () {
        final transactionRepo = MockTransactionRepository();
        final categoryRepo = MockCategoryRepository();
        return DashboardBloc(GetDashboardData(transactionRepo, categoryRepo));
      },
      verify: (bloc) {
        expect(bloc.state.status, DashboardStatus.initial);
        expect(bloc.state.totalBalance, 0.0);
        expect(bloc.state.incomeExpense, isNull);
        expect(bloc.state.todaySummary, isNull);
        expect(bloc.state.topExpense, isNull);
        expect(bloc.state.spendingByCategory, isEmpty);
        expect(bloc.state.monthlyTrend, isEmpty);
        expect(bloc.state.errorMessage, isNull);
      },
    );

    blocTest<DashboardBloc, DashboardState>(
      'LoadDashboardData emits [loading, success] with correct data when successful',
      build: () {
        final transactionRepo = MockTransactionRepository(
          initial: testTransactions,
        );
        final categoryRepo = MockCategoryRepository(initial: [testCategory]);
        return DashboardBloc(GetDashboardData(transactionRepo, categoryRepo));
      },
      act: (bloc) => bloc.add(const LoadDashboardData()),
      expect: () => [
        predicate<DashboardState>(
          (state) => state.status == DashboardStatus.loading,
        ),
        predicate<DashboardState>(
          (state) =>
              state.status == DashboardStatus.success &&
              state.totalBalance == 2500.0 &&
              state.incomeExpense?.income == 2650.0 &&
              state.incomeExpense?.expense == 150.0 &&
              state.todaySummary?.transactionCount == 2 &&
              state.topExpense?.transaction.id == '1' &&
              state.spendingByCategory.length == 1,
        ),
      ],
    );

    blocTest<DashboardBloc, DashboardState>(
      'LoadDashboardData emits [loading, failure] when error occurs',
      build: () {
        final transactionRepo = MockTransactionRepository(
          exception: Exception('Failed to load dashboard data'),
        );
        final categoryRepo = MockCategoryRepository();
        return DashboardBloc(GetDashboardData(transactionRepo, categoryRepo));
      },
      act: (bloc) => bloc.add(const LoadDashboardData()),
      expect: () => [
        predicate<DashboardState>(
          (state) => state.status == DashboardStatus.loading,
        ),
        predicate<DashboardState>(
          (state) =>
              state.status == DashboardStatus.failure &&
              state.errorMessage != null &&
              state.errorMessage!.contains('Failed to load'),
        ),
      ],
    );

    blocTest<DashboardBloc, DashboardState>(
      'state contains all dashboard data fields correctly',
      build: () {
        final transactionRepo = MockTransactionRepository(
          initial: testTransactions,
        );
        final categoryRepo = MockCategoryRepository(initial: [testCategory]);
        return DashboardBloc(GetDashboardData(transactionRepo, categoryRepo));
      },
      act: (bloc) => bloc.add(const LoadDashboardData()),
      skip: 1,
      verify: (bloc) {
        final state = bloc.state;
        expect(state.status, DashboardStatus.success);
        expect(state.totalBalance, 2500.0);

        expect(state.incomeExpense?.income, 2650.0);
        expect(state.incomeExpense?.expense, 150.0);
        expect(state.incomeExpense?.balance, 2500.0);

        expect(state.todaySummary?.income, 2650.0);
        expect(state.todaySummary?.expense, 150.0);
        expect(state.todaySummary?.transactionCount, 2);
        expect(state.todaySummary?.balance, 2500.0);

        expect(state.topExpense?.transaction.title, 'Groceries');
        expect(state.topExpense?.transaction.amount, 150.0);
        expect(state.topExpense?.category.name, 'Food');

        expect(state.spendingByCategory.length, 1);
        expect(state.spendingByCategory.first.amount, 150.0);
        expect(state.spendingByCategory.first.percentage, 1.0);

        expect(state.monthlyTrend.isNotEmpty, true);
      },
    );
  });
}
