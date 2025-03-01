import 'package:expense_tracker/expense/data_models/expense.dart';

class ExpenseTestFactory {
  ExpenseTestFactory._();

  static Expense get expenseWithoutCategory => Expense(
    createdAt: DateTime(2025, 2, 28, 20, 38),
    expenseDateTime: DateTime(2025, 2, 28, 20, 38),
    amount: 42.42,
    description: 'description',
  );

  static Expense get expenseFirstMarch => Expense(
    createdAt: DateTime(2025, 2, 28, 20, 38),
    expenseDateTime: DateTime(2025, 3, 1, 20, 38),
    amount: 32.42,
    description: 'description',
  );

  static Expense get expense28thFebruary => Expense(
    createdAt: DateTime(2025, 2, 28, 20, 38),
    expenseDateTime: DateTime(2025, 2, 28, 10, 38),
    amount: 22.42,
    description: 'description',
  );

  static Expense get expenseSecondMarch => Expense(
    createdAt: DateTime(2025, 2, 28, 20, 38),
    expenseDateTime: DateTime(2025, 3, 2, 20, 38),
    amount: 12.42,
    description: 'description',
  );
}
