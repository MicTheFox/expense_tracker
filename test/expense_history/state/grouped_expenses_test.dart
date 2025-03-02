import 'dart:collection';

import 'package:expense_tracker/expense_history/state/grouped_expenses.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../expense_test_factory.dart';

void main() {
  test('totalAmount is calculated correctly', () async {
    final groupedExpenses = GroupedExpenses(
      expenses: UnmodifiableListView([
        ExpenseTestFactory.expenseWithoutCategory,
        ExpenseTestFactory.expense28thFebruary,
      ]),
      date: DateTime(2025, 2, 28),
    );

    expect(groupedExpenses.totalAmount, 42.42 + 22.42);
  });
}
