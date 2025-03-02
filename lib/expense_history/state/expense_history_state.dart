import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense_history/state/grouped_expenses.dart';
import 'package:expense_tracker/utils/datetime_extension.dart';

sealed class ExpenseHistoryState extends Equatable {}

final class ExpenseHistoryUnloaded extends ExpenseHistoryState {
  @override
  List<Object?> get props => [];
}

final class ExpenseHistoryLoaded extends ExpenseHistoryState {
  final UnmodifiableListView<Expense> expenses;
  final Category? categoryFilter;

  ExpenseHistoryLoaded({required this.expenses, this.categoryFilter});

  @override
  List<Object?> get props => [expenses, categoryFilter];

  Iterable<Expense> get _filteredExpenses =>
      categoryFilter == null
          ? expenses
          : expenses.where((expense) => expense.category == categoryFilter);

  UnmodifiableListView<GroupedExpenses> get groupedExpenses {
    final groupedExpenses =
        _filteredExpenses
            .fold<Map<DateTime, List<Expense>>>({}, _groupExpensesByDate)
            .map(_toGroupedExpensesMap)
            .values
            .toList();

    groupedExpenses.sort(
      (groupA, groupB) => groupB.date.compareTo(groupA.date),
    );

    return UnmodifiableListView(groupedExpenses);
  }

  UnmodifiableListView<(DateTime, double)> get monthlyAmountsOfLastYear {
    final oneYearAgo = DateTime.now().subtract(const Duration(days: 365));
    final monthlyAmounts =
        _filteredExpenses
            .where((expense) => expense.expenseDateTime.isAfter(oneYearAgo))
            .fold<Map<DateTime, List<Expense>>>({}, _groupExpensesByMonth)
            .map(
              (key, value) => MapEntry(key, (
                key,
                value
                    .map((expense) => expense.amount)
                    .reduce((amountA, amountB) => amountA + amountB),
              )),
            )
            .values;

    monthlyAmounts.toList().sort(
      (groupA, groupB) => groupB.$1.compareTo(groupA.$1),
    );

    return UnmodifiableListView(monthlyAmounts);
  }

  MapEntry<DateTime, GroupedExpenses> _toGroupedExpensesMap(
    DateTime date,
    List<Expense> expenses,
  ) {
    expenses.sort(
      (expenseA, expenseB) => expenseB.createdAt.compareTo(expenseA.createdAt),
    );
    return MapEntry(
      date,
      GroupedExpenses(date: date, expenses: UnmodifiableListView(expenses)),
    );
  }

  Map<DateTime, List<Expense>> _groupExpensesByDate(
    Map<DateTime, List<Expense>> current,
    Expense newExpense,
  ) => _groupExpensesBy(
    current,
    newExpense,
    (dateTime) => dateTime.dateWithoutTime,
  );

  Map<DateTime, List<Expense>> _groupExpensesByMonth(
    Map<DateTime, List<Expense>> current,
    Expense newExpense,
  ) => _groupExpensesBy(current, newExpense, (dateTime) => dateTime.dateMonth);

  Map<DateTime, List<Expense>> _groupExpensesBy(
    Map<DateTime, List<Expense>> current,
    Expense newExpense,
    DateTime Function(DateTime datetime) groupBy,
  ) {
    final date = groupBy(newExpense.expenseDateTime);

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
