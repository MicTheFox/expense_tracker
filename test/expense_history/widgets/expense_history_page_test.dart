import 'dart:collection';

import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/expense_history/state/expense_history_cubit.dart';
import 'package:expense_tracker/expense_history/state/expense_history_state.dart';
import 'package:expense_tracker/expense_history/widgets/expense_history_page.dart';
import 'package:expense_tracker/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../expense_test_factory.dart';

class MockExpenseHistoryCubit extends MockCubit<ExpenseHistoryState>
    implements ExpenseHistoryCubit {}

void main() {
  late final Widget widget;
  late final ExpenseHistoryCubit mockExpenseHistoryCubit;

  final expenses = [
    ExpenseTestFactory.expenseWithoutCategory,
    ExpenseTestFactory.expenseFirstMarch,
    ExpenseTestFactory.expense28thFebruary,
    ExpenseTestFactory.expenseSecondMarch,
  ];

  setUpAll(() {
    mockExpenseHistoryCubit = MockExpenseHistoryCubit();

    widget = BlocProvider<ExpenseHistoryCubit>(
      create: (_) => mockExpenseHistoryCubit,
      child: const MaterialApp(home: Scaffold(body: ExpenseHistoryPage())),
    );
  });

  testWidgets('shows is empty message if there are no expenses', (
    WidgetTester tester,
  ) async {
    when(
      () => mockExpenseHistoryCubit.state,
    ).thenReturn(ExpenseHistoryLoaded(expenses: UnmodifiableListView([])));

    await tester.pumpWidget(widget);

    expect(find.byKey(expenseHistoryPageEmptyKey), findsOneWidget);
  });

  testWidgets('displays correct number of headline and list tiles', (
    WidgetTester tester,
  ) async {
    when(() => mockExpenseHistoryCubit.state).thenReturn(
      ExpenseHistoryLoaded(expenses: UnmodifiableListView(expenses)),
    );

    await tester.pumpWidget(widget);

    expect(
      find.byKey(expenseHistoryPageHeadlineKey, skipOffstage: false),
      findsNWidgets(3),
    );
    expect(
      find.byKey(expenseHistoryPageListTileKey, skipOffstage: false),
      findsNWidgets(4),
    );
  });
}
