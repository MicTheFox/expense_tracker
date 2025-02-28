import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/main.dart';

class ExpenseRepository {
  final db = localStorage.store.box<Expense>();

  Future<List<Expense>> getAll() async {
    return db.getAll();
  }

  Future<int> put(Expense expense) async {
    return db.put(expense);
  }
}
