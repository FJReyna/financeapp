import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/category/domain/repository/category_repository.dart';
import 'package:finance/features/dashboard/domain/entities/category_spending.dart';
import 'package:finance/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:finance/features/dashboard/domain/entities/income_expense_data.dart';
import 'package:finance/features/dashboard/domain/entities/today_summary_data.dart';
import 'package:finance/features/dashboard/domain/entities/top_expense_data.dart';
import 'package:finance/features/dashboard/domain/entities/trend_point.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';
import 'package:flutter/material.dart';

class GetDashboardData extends UseCase<DashboardData, Null> {
  final TransactionRepository transactionRepository;
  final CategoryRepository categoryRepository;

  GetDashboardData(this.transactionRepository, this.categoryRepository);

  @override
  Future<Either<Exception, DashboardData>> call(Null params) async {
    try {
      final List<Transaction> transactions = await transactionRepository
          .getTransactions();
      final List<Category> categories = await categoryRepository
          .getCategories();

      final double totalBalance = _calculateTotalBalance(transactions);
      final IncomeExpenseData incomeExpense = _calculateIncomeExpense(
        transactions,
      );
      final TodaySummaryData todaySummary = _calculateTodaySummary(
        transactions,
      );
      final TopExpenseData? topExpense = _calculateTopExpense(
        transactions,
        categories,
      );
      final List<CategorySpending> spendingByCategory =
          _calculateSpendingByCategory(transactions, categories);
      final List<TrendPoint> monthlyTrend = _calculateMonthlyTrend(
        transactions,
      );

      return Right(
        DashboardData(
          totalBalance: totalBalance,
          incomeExpense: incomeExpense,
          todaySummary: todaySummary,
          topExpense: topExpense,
          spendingByCategory: spendingByCategory,
          monthlyTrend: monthlyTrend,
        ),
      );
    } catch (e) {
      return Left(Exception('Failed to load dashboard data: $e'));
    }
  }

  double _calculateTotalBalance(List<Transaction> transactions) {
    double balance = 0.0;

    for (Transaction transaction in transactions) {
      if (transaction.type == TransactionType.income) {
        balance += transaction.amount;
      } else {
        balance -= transaction.amount;
      }
    }

    return balance;
  }

  IncomeExpenseData _calculateIncomeExpense(List<Transaction> transactions) {
    double totalIncome = 0.0;
    double totalExpense = 0.0;

    for (Transaction transaction in transactions) {
      if (transaction.type == TransactionType.income) {
        totalIncome += transaction.amount;
      } else {
        totalExpense += transaction.amount;
      }
    }

    return IncomeExpenseData(income: totalIncome, expense: totalExpense);
  }

  TodaySummaryData _calculateTodaySummary(List<Transaction> transactions) {
    final now = DateTime.now();

    final todayTransactions = transactions.where((Transaction transaction) {
      return transaction.date.year == now.year &&
          transaction.date.month == now.month &&
          transaction.date.day == now.day;
    }).toList();

    double totalIncome = 0.0;
    double totalExpense = 0.0;

    for (Transaction transaction in todayTransactions) {
      if (transaction.type == TransactionType.income) {
        totalIncome += transaction.amount;
      } else {
        totalExpense += transaction.amount;
      }
    }

    return TodaySummaryData(
      income: totalIncome,
      expense: totalExpense,
      transactionCount: todayTransactions.length,
    );
  }

  TopExpenseData? _calculateTopExpense(
    List<Transaction> transactions,
    List<Category> categories,
  ) {
    final expenses = transactions
        .where(
          (Transaction transaction) =>
              transaction.type == TransactionType.expense,
        )
        .toList();

    if (expenses.isEmpty) {
      return null;
    }

    expenses.sort(
      (Transaction a, Transaction b) => b.amount.compareTo(a.amount),
    );
    final topExpense = expenses.first;

    final category = categories.firstWhere(
      (Category category) => category.id == topExpense.categoryId,
      orElse: () => Category(
        id: 'unknown',
        name: 'Unknown',
        icon: Icons.help_outline,
        color: Colors.grey,
      ),
    );

    return TopExpenseData(transaction: topExpense, category: category);
  }

  List<CategorySpending> _calculateSpendingByCategory(
    List<Transaction> transactions,
    List<Category> categories,
  ) {
    final expenses = transactions
        .where(
          (Transaction transaction) =>
              transaction.type == TransactionType.expense,
        )
        .toList();

    final double totalExpense = expenses.fold<double>(
      0.0,
      (double sum, Transaction transaction) => sum + transaction.amount,
    );

    final Map<String, double> categoryTotals = {};

    for (var transaction in expenses) {
      categoryTotals[transaction.categoryId] =
          (categoryTotals[transaction.categoryId] ?? 0.0) + transaction.amount;
    }

    final List<CategorySpending> result = [];

    for (var entry in categoryTotals.entries) {
      final category = categories.firstWhere(
        (Category category) => category.id == entry.key,
        orElse: () => Category(
          id: 'unknown',
          name: 'Unknown',
          icon: Icons.help_outline,
          color: Colors.grey,
        ),
      );

      result.add(
        CategorySpending(
          category: category,
          amount: entry.value,
          percentage: totalExpense > 0 ? (entry.value / totalExpense) : 0.0,
        ),
      );
    }

    result.sort((a, b) => b.amount.compareTo(a.amount));

    return result;
  }

  List<TrendPoint> _calculateMonthlyTrend(List<Transaction> transactions) {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;

    final Iterable<Transaction> monthTransactions = transactions.where((
      transaction,
    ) {
      return transaction.date.isAfter(
            firstDayOfMonth.subtract(const Duration(days: 1)),
          ) &&
          transaction.date.isBefore(
            lastDayOfMonth.add(const Duration(days: 1)),
          );
    }).toList();

    final Map<int, TrendPoint> weeklyData = {};

    for (Transaction transaction in monthTransactions) {
      final day = transaction.date.day;
      final weekNumber = ((day - 1) ~/ 7) + 1;

      final x = (weekNumber * 7).toDouble();

      if (!weeklyData.containsKey(weekNumber)) {
        weeklyData[weekNumber] = TrendPoint(
          date: DateTime(now.year, now.month, weekNumber * 7),
          income: 0.0,
          expense: 0.0,
          x: x,
        );
      }

      if (transaction.type == TransactionType.income) {
        weeklyData[weekNumber] = TrendPoint(
          date: weeklyData[weekNumber]!.date,
          income: weeklyData[weekNumber]!.income + transaction.amount,
          expense: weeklyData[weekNumber]!.expense,
          x: x,
        );
      } else {
        weeklyData[weekNumber] = TrendPoint(
          date: weeklyData[weekNumber]!.date,
          income: weeklyData[weekNumber]!.income,
          expense: weeklyData[weekNumber]!.expense + transaction.amount,
          x: x,
        );
      }
    }

    final numberOfWeeks = (daysInMonth / 7).ceil();
    for (int week = 1; week <= numberOfWeeks; week++) {
      if (!weeklyData.containsKey(week)) {
        weeklyData[week] = TrendPoint(
          date: DateTime(now.year, now.month, week * 7),
          income: 0.0,
          expense: 0.0,
          x: (week * 7).toDouble(),
        );
      }
    }

    final List<TrendPoint> result = weeklyData.values.toList();
    result.sort((TrendPoint a, TrendPoint b) => a.x.compareTo(b.x));

    return result;
  }
}
