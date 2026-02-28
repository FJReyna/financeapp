import 'package:dartz/dartz.dart';
import 'package:finance/core/usecase/usecase.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/category/domain/repository/category_repository.dart';
import 'package:finance/features/dashboard/domain/entities/category_spending.dart';
import 'package:finance/features/stats/domain/entities/bar_chart_point.dart';
import 'package:finance/features/stats/domain/entities/stats_data.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';
import 'package:flutter/material.dart';

enum StatsPeriod { week, month, year }

class StatsParams {
  final StatsPeriod period;

  StatsParams({required this.period});
}

class GetStatsData extends UseCase<StatsData, StatsParams> {
  final TransactionRepository transactionRepository;
  final CategoryRepository categoryRepository;

  GetStatsData(this.transactionRepository, this.categoryRepository);

  @override
  Future<Either<Exception, StatsData>> call(StatsParams params) async {
    try {
      final List<Transaction> transactions = await transactionRepository
          .getTransactions();
      final List<Category> categories = await categoryRepository
          .getCategories();

      final List<Transaction> periodTransactions = _filterTransactionsByPeriod(
        transactions,
        params.period,
      );

      final double totalIncome = _calculateTotalIncome(periodTransactions);
      final double totalExpense = _calculateTotalExpense(periodTransactions);
      final List<BarChartPoint> chartData = _calculateChartData(
        periodTransactions,
        params.period,
      );
      final List<CategorySpending> topCategories = _calculateTopCategories(
        periodTransactions,
        categories,
      );

      return Right(
        StatsData(
          totalIncome: totalIncome,
          totalExpense: totalExpense,
          chartData: chartData,
          topCategories: topCategories,
        ),
      );
    } catch (e) {
      return Left(Exception('Failed to load stats data: $e'));
    }
  }

  List<Transaction> _filterTransactionsByPeriod(
    List<Transaction> transactions,
    StatsPeriod period,
  ) {
    final now = DateTime.now();

    switch (period) {
      case StatsPeriod.week:
        final DateTime weekAgo = now.subtract(const Duration(days: 7));
        return transactions
            .where(
              (Transaction transaction) =>
                  transaction.date.isAfter(weekAgo) &&
                  transaction.date.isBefore(now.add(const Duration(days: 1))),
            )
            .toList();
      case StatsPeriod.month:
        final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
        final DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
        return transactions
            .where(
              (Transaction transaction) =>
                  transaction.date.isAfter(
                    firstDayOfMonth.subtract(const Duration(days: 1)),
                  ) &&
                  transaction.date.isBefore(
                    lastDayOfMonth.add(const Duration(days: 1)),
                  ),
            )
            .toList();
      case StatsPeriod.year:
        final DateTime firstDayOfYear = DateTime(now.year, 1, 1);
        final DateTime lastDayOfYear = DateTime(now.year, 12, 31);
        return transactions
            .where(
              (Transaction transaction) =>
                  transaction.date.isAfter(
                    firstDayOfYear.subtract(const Duration(days: 1)),
                  ) &&
                  transaction.date.isBefore(
                    lastDayOfYear.add(const Duration(days: 1)),
                  ),
            )
            .toList();
    }
  }

  double _calculateTotalIncome(List<Transaction> transactions) {
    return transactions
        .where(
          (Transaction transaction) =>
              transaction.type == TransactionType.income,
        )
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double _calculateTotalExpense(List<Transaction> transactions) {
    return transactions
        .where(
          (Transaction transaction) =>
              transaction.type == TransactionType.expense,
        )
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  List<BarChartPoint> _calculateChartData(
    List<Transaction> transactions,
    StatsPeriod period,
  ) {
    switch (period) {
      case StatsPeriod.week:
        return _calculateWeekChartData(transactions);
      case StatsPeriod.month:
        return _calculateMonthChartData(transactions);
      case StatsPeriod.year:
        return _calculateYearChartData(transactions);
    }
  }

  List<BarChartPoint> _calculateWeekChartData(List<Transaction> transactions) {
    final now = DateTime.now();
    final Map<int, BarChartPoint> dayData = {};

    for (int i = 0; i < 7; i++) {
      dayData[i] = BarChartPoint(
        index: i,
        income: 0.0,
        expense: 0.0,
      );
    }

    for (Transaction transaction in transactions) {
      final int daysSinceMonday = (now.weekday - DateTime.monday + 7) % 7;
      final DateTime monday = now.subtract(Duration(days: daysSinceMonday));

      final int dayIndex = transaction.date.difference(monday).inDays;

      if (dayIndex >= 0 && dayIndex < 7) {
        final BarChartPoint current = dayData[dayIndex]!;

        dayData[dayIndex] = BarChartPoint(
          index: dayIndex,
          income:
              current.income +
              (transaction.type == TransactionType.income
                  ? transaction.amount
                  : 0),
          expense:
              current.expense +
              (transaction.type == TransactionType.expense
                  ? transaction.amount
                  : 0),
        );
      }
    }

    return dayData.values.toList()..sort((a, b) => a.index.compareTo(b.index));
  }

  List<BarChartPoint> _calculateMonthChartData(List<Transaction> transactions) {
    final DateTime now = DateTime.now();
    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final int numberOfWeeks = (daysInMonth / 7).ceil();

    final Map<int, BarChartPoint> weekData = {};

    for (int i = 0; i < numberOfWeeks; i++) {
      weekData[i] = BarChartPoint(
        index: i,
        income: 0.0,
        expense: 0.0,
      );
    }

    for (Transaction transaction in transactions) {
      final int day = transaction.date.day;
      final int weekNumber = ((day - 1) ~/ 7);

      if (weekNumber >= 0 && weekNumber < numberOfWeeks) {
        final BarChartPoint current = weekData[weekNumber]!;

        weekData[weekNumber] = BarChartPoint(
          index: weekNumber,
          income:
              current.income +
              (transaction.type == TransactionType.income
                  ? transaction.amount
                  : 0),
          expense:
              current.expense +
              (transaction.type == TransactionType.expense
                  ? transaction.amount
                  : 0),
        );
      }
    }

    return weekData.values.toList()..sort((a, b) => a.index.compareTo(b.index));
  }

  List<BarChartPoint> _calculateYearChartData(List<Transaction> transactions) {
    final Map<int, BarChartPoint> monthData = {};

    for (int i = 0; i < 12; i++) {
      monthData[i] = BarChartPoint(
        index: i,
        income: 0.0,
        expense: 0.0,
      );
    }

    for (Transaction transaction in transactions) {
      final int monthIndex = transaction.date.month - 1;

      if (monthIndex >= 0 && monthIndex < 12) {
        final BarChartPoint current = monthData[monthIndex]!;

        monthData[monthIndex] = BarChartPoint(
          index: monthIndex,
          income:
              current.income +
              (transaction.type == TransactionType.income
                  ? transaction.amount
                  : 0),
          expense:
              current.expense +
              (transaction.type == TransactionType.expense
                  ? transaction.amount
                  : 0),
        );
      }
    }

    return monthData.values.toList()
      ..sort((a, b) => a.index.compareTo(b.index));
  }

  List<CategorySpending> _calculateTopCategories(
    List<Transaction> transactions,
    List<Category> categories,
  ) {
    final List<Transaction> expenses = transactions
        .where(
          (Transaction transaction) =>
              transaction.type == TransactionType.expense,
        )
        .toList();

    if (expenses.isEmpty) {
      return [];
    }

    final double totalExpense = expenses.fold<double>(
      0.0,
      (double sum, Transaction transaction) => sum + transaction.amount,
    );

    final Map<String, double> categoryTotals = {};

    for (Transaction transaction in expenses) {
      categoryTotals[transaction.categoryId] =
          (categoryTotals[transaction.categoryId] ?? 0.0) + transaction.amount;
    }

    final List<CategorySpending> result = [];

    for (MapEntry<String, double> entry in categoryTotals.entries) {
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

    result.sort(
      (CategorySpending a, CategorySpending b) => b.amount.compareTo(a.amount),
    );

    return result.take(5).toList();
  }
}
