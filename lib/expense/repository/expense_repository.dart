import 'dart:async';

import 'package:expense_tracker/expense/data_models/expense.dart';

abstract interface class ExpenseRepository {
  Stream<Expense> get expenseUpdates;

  Future<List<Expense>> getAll();

  Future<int> put(Expense expense);
}
