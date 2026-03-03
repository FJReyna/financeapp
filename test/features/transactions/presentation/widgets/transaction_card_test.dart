import 'package:dartz/dartz.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:finance/features/transactions/domain/entities/transaction_with_category.dart';
import 'package:finance/features/transactions/domain/usecase/add_transaction.dart';
import 'package:finance/features/transactions/domain/usecase/delete_transaction.dart';
import 'package:finance/features/transactions/domain/usecase/get_all_transactions.dart';
import 'package:finance/features/transactions/domain/usecase/get_transaction.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:finance/features/transactions/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finance/l10n/app_localizations.dart';

class MockGetAllTransactions extends GetAllTransactions {
  MockGetAllTransactions() : super(null as dynamic, null as dynamic);

  @override
  Future<Either<Exception, List<TransactionWithCategory>>> call(
    Null params,
  ) async {
    return Right([]);
  }
}

class MockGetTransaction extends GetTransaction {
  MockGetTransaction() : super(null as dynamic);

  @override
  Future<Either<Exception, Transaction>> call(String params) async {
    return Left(Exception('Not found'));
  }
}

class MockAddTransaction extends AddTransaction {
  MockAddTransaction() : super(null as dynamic);

  @override
  Future<Either<Exception, void>> call(AddTransactionParams params) async {
    return const Right(null);
  }
}

class MockDeleteTransaction extends DeleteTransaction {
  MockDeleteTransaction() : super(null as dynamic);

  @override
  Future<Either<Exception, void>> call(String params) async {
    return const Right(null);
  }
}

void main() {
  group('TransactionCard Widget Tests', () {
    late TransactionWithCategory expenseTransaction;
    late TransactionWithCategory incomeTransaction;

    setUp(() {
      expenseTransaction = TransactionWithCategory(
        transaction: Transaction(
          id: '1',
          title: 'Grocery Shopping',
          amount: 50.00,
          type: TransactionType.expense,
          categoryId: 'cat1',
          description: 'Weekly groceries',
          date: DateTime(2024, 2, 15),
        ),
        category: Category(
          id: 'cat1',
          name: 'Food',
          icon: Icons.restaurant,
          color: Colors.orange,
        ),
      );
      incomeTransaction = TransactionWithCategory(
        transaction: Transaction(
          id: '2',
          title: 'Salary',
          amount: 2000.00,
          type: TransactionType.income,
          categoryId: 'cat2',
          description: 'Monthly salary',
          date: DateTime(2024, 2, 1),
        ),
        category: Category(
          id: 'cat2',
          name: 'Income',
          icon: Icons.attach_money,
          color: Colors.green,
        ),
      );
    });

    Widget createTestWidget(TransactionWithCategory transaction) {
      return BlocProvider<TransactionsBloc>(
        create: (_) => TransactionsBloc(
          MockGetAllTransactions(),
          MockGetTransaction(),
          MockAddTransaction(),
          MockDeleteTransaction(),
        ),
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('es')],
          home: Scaffold(body: TransactionCard(transaction: transaction)),
        ),
      );
    }

    testWidgets('renders transaction title correctly', (tester) async {
      await tester.pumpWidget(createTestWidget(expenseTransaction));

      expect(find.text('Grocery Shopping'), findsOneWidget);
    });

    testWidgets('renders expense amount with negative sign and red color', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget(expenseTransaction));

      final Finder amountFinder = find.text('- \$50.0');
      expect(amountFinder, findsOneWidget);

      final Text textWidget = tester.widget<Text>(amountFinder);
      expect(textWidget.style?.color, Colors.red);
    });

    testWidgets('renders income amount with positive sign and green color', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget(incomeTransaction));

      final Finder amountFinder = find.text('+ \$2000.0');
      expect(amountFinder, findsOneWidget);

      final Text textWidget = tester.widget<Text>(amountFinder);
      expect(textWidget.style?.color, Colors.green);
    });

    testWidgets('renders category name', (tester) async {
      await tester.pumpWidget(createTestWidget(expenseTransaction));

      expect(find.text('Food'), findsOneWidget);
    });

    testWidgets('renders category icon with correct color', (tester) async {
      await tester.pumpWidget(createTestWidget(expenseTransaction));

      final Finder avatarFinder = find.byType(CircleAvatar);
      expect(avatarFinder, findsOneWidget);

      final Finder iconFinder = find.descendant(
        of: avatarFinder,
        matching: find.byIcon(Icons.restaurant),
      );
      expect(iconFinder, findsOneWidget);

      final Icon icon = tester.widget<Icon>(iconFinder);
      expect(icon.color, Colors.orange);
    });

    testWidgets('renders transaction date', (tester) async {
      await tester.pumpWidget(createTestWidget(expenseTransaction));

      expect(find.text('2024-02-15'), findsOneWidget);
    });

    testWidgets('card is wrapped in Dismissible widget', (tester) async {
      await tester.pumpWidget(createTestWidget(expenseTransaction));

      final Finder dismissibleFinder = find.byType(Dismissible);
      expect(dismissibleFinder, findsOneWidget);

      final Dismissible dismissible = tester.widget<Dismissible>(
        dismissibleFinder,
      );
      expect(dismissible.direction, DismissDirection.endToStart);
    });

    testWidgets('card displays ListTile with all components', (tester) async {
      await tester.pumpWidget(createTestWidget(expenseTransaction));

      expect(find.byType(ListTile), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });
  });
}
