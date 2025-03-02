import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/expense/data_models/expense.dart';

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
