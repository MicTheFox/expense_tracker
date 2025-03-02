import 'dart:async';

import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/repository/expense_repository.dart';
import 'package:objectbox/objectbox.dart';

final class LocalExpenseRepository implements ExpenseRepository {
  final Box<Expense> db;

  LocalExpenseRepository({required this.db});

  final StreamController<Expense> _expenseUpdateController =
      StreamController.broadcast();

  @override
  Stream<Expense> get expenseUpdates => _expenseUpdateController.stream;

  @override
  Future<List<Expense>> getAll() async {
    return db.getAll();
  }

  @override
  Future<int> put(Expense expense) async {
    final id = db.put(expense);

    _expenseUpdateController.add(expense);
    return id;
  }
}
