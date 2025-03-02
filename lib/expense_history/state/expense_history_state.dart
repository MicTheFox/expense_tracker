import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/utils/datetime_extension.dart';

sealed class ExpenseHistoryState extends Equatable {}

final class ExpenseHistoryUnloaded extends ExpenseHistoryState {
  @override
  List<Object?> get props => [];
}

final class ExpenseHistoryLoaded extends ExpenseHistoryState {
  final UnmodifiableListView<Expense> expenses;

  ExpenseHistoryLoaded({required this.expenses});

  @override
  List<Object?> get props => [expenses];

  UnmodifiableListView<GroupedExpenses> get groupedExpenses {
    final groupedExpenses =
        expenses
            .fold<Map<DateTime, List<Expense>>>({}, _groupExpensesByDate)
            .map(_toGroupedExpensesMap)
            .values
            .toList();

    groupedExpenses.sort(
      (groupA, groupB) => groupB.date.compareTo(groupA.date),
    );

    return UnmodifiableListView(groupedExpenses);
  }

  MapEntry<DateTime, GroupedExpenses> _toGroupedExpensesMap(
    DateTime date,
    List<Expense> expenses,
  ) => MapEntry(
    date,
    GroupedExpenses(date: date, expenses: UnmodifiableListView(expenses)),
  );

  Map<DateTime, List<Expense>> _groupExpensesByDate(
    Map<DateTime, List<Expense>> current,
    Expense newExpense,
  ) {
    final date = newExpense.expenseDateTime.dateWithoutTime;

    if (current.containsKey(date)) {
      current[date] = [...current[date]!, newExpense];
    } else {
      current[date] = [newExpense];
    }

    return current;
  }
}

final class ExpenseHistoryError extends ExpenseHistoryState {
  ExpenseHistoryError();

  @override
  List<Object?> get props => [];
}

class GroupedExpenses extends Equatable {
  final UnmodifiableListView<Expense> expenses;
  final DateTime date;

  const GroupedExpenses({required this.expenses, required this.date});

  @override
  List<Object?> get props => [date, expenses];

  double get totalAmount => expenses
      .map((expense) => expense.amount)
      .reduce((first, second) => first + second);
}
