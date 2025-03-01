import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/repository/expense_repository.dart';
import 'package:expense_tracker/main.dart';

final class LocalExpenseRepository implements ExpenseRepository {
  final db = localStorage.store.box<Expense>();

  @override
  Future<List<Expense>> getAll() async {
    return db.getAll();
  }

  @override
  Future<int> put(Expense expense) async {
    return db.put(expense);
  }
}
