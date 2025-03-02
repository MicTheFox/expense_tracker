import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/expense/state/expense_cubit.dart';
import 'package:expense_tracker/expense/state/expense_state.dart';
import 'package:expense_tracker/expense/widgets/add_expense_form.dart';
import 'package:expense_tracker/expense/widgets/add_expense_page.dart';
import 'package:expense_tracker/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../expense_test_factory.dart';

class MockExpenseCubit extends MockCubit<ExpenseState>
    implements ExpenseCubit {}

void main() {
  late final Widget widget;
  late final ExpenseCubit mockExpenseCubit;

  setUpAll(() {
    mockExpenseCubit = MockExpenseCubit();

    widget = BlocProvider<ExpenseCubit>(
      create: (_) => mockExpenseCubit,
      child: const MaterialApp(home: Scaffold(body: AddExpensePage())),
    );
  });

  testWidgets('displays headline', (WidgetTester tester) async {
    when(() => mockExpenseCubit.state).thenReturn(ExpenseEmpty());

    await tester.pumpWidget(widget);

    expect(find.text('Add expense'), findsOneWidget);
  });

  testWidgets('displays AddExpenseForm initially', (WidgetTester tester) async {
    when(() => mockExpenseCubit.state).thenReturn(ExpenseEmpty());

    await tester.pumpWidget(widget);

    expect(find.byType(AddExpenseForm), findsOneWidget);
  });

  testWidgets('displays AddExpenseForm if state is ExpenseAdding', (
    WidgetTester tester,
  ) async {
    when(() => mockExpenseCubit.state).thenReturn(
      ExpenseAdding(expense: ExpenseTestFactory.expenseWithoutCategory),
    );

    await tester.pumpWidget(widget);

    expect(find.byType(AddExpenseForm), findsOneWidget);
  });

  testWidgets(
    'displays added expense SnackBar if state ExpenseAdded is emitted',
    (WidgetTester tester) async {
      whenListen(
        mockExpenseCubit,
        Stream.fromIterable([
          ExpenseAdded(expense: ExpenseTestFactory.expenseWithoutCategory),
        ]),
        initialState: ExpenseEmpty(),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      mockExpenseCubit.add(ExpenseTestFactory.expenseWithoutCategory);
      await tester.pumpAndSettle();

      expect(find.byKey(addExpensePageAddedKey), findsOneWidget);
    },
  );

  testWidgets('displays error if state is ExpenseAddedError', (
    WidgetTester tester,
  ) async {
    whenListen(
      mockExpenseCubit,
      Stream.fromIterable([
        ExpenseAddedError(expense: ExpenseTestFactory.expenseWithoutCategory),
      ]),
      initialState: ExpenseEmpty(),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    mockExpenseCubit.add(ExpenseTestFactory.expenseWithoutCategory);
    await tester.pumpAndSettle();

    expect(find.byKey(addExpensePageErrorKey), findsOneWidget);
  });
}
