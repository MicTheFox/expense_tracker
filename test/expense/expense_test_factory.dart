import 'package:expense_tracker/expense/data_models/expense.dart';

class ExpenseTestFactory {
  ExpenseTestFactory._();

  static Expense get expenseWithoutCategory => Expense(
    createdAt: DateTime(2025, 2, 28, 20, 38),
    amount: 42.42,
    description: 'description',
  );
}
