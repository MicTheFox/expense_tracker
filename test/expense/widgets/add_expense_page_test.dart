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
      child: const MaterialApp(home: Material(child: AddExpensePage())),
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

  testWidgets('displays error if state is ExpenseAddedError', (
    WidgetTester tester,
  ) async {
    when(() => mockExpenseCubit.state).thenReturn(
      ExpenseAddedError(expense: ExpenseTestFactory.expenseWithoutCategory),
    );

    await tester.pumpWidget(widget);

    expect(find.byKey(addExpensePageErrorKey), findsOneWidget);
  });
}
