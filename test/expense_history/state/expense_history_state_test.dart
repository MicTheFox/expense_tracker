import 'dart:collection';

import 'package:expense_tracker/expense_history/state/expense_history_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../expense_test_factory.dart';

void main() {
  final expenses = [
    ExpenseTestFactory.expenseWithoutCategory,
    ExpenseTestFactory.expenseFirstMarch,
    ExpenseTestFactory.expense28thFebruary,
    ExpenseTestFactory.expenseSecondMarch,
  ];

  test('returns grouped expenses in descending date order', () async {
    final state = ExpenseHistoryLoaded(
      expenses: UnmodifiableListView(expenses),
    );

    final expected = UnmodifiableListView([
      GroupedExpenses(
        expenses: UnmodifiableListView([ExpenseTestFactory.expenseSecondMarch]),
        date: DateTime(2025, 3, 2),
      ),
      GroupedExpenses(
        expenses: UnmodifiableListView([ExpenseTestFactory.expenseFirstMarch]),
        date: DateTime(2025, 3, 1),
      ),
      GroupedExpenses(
        expenses: UnmodifiableListView([
          ExpenseTestFactory.expenseWithoutCategory,
          ExpenseTestFactory.expense28thFebruary,
        ]),
        date: DateTime(2025, 2, 28),
      ),
    ]);

    expect(state.groupedExpenses, expected);
  });
}
