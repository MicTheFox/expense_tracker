import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../expense_test_factory.dart';

void main() {
  final expenseWithoutCategory = ExpenseTestFactory.expenseWithoutCategory;

  group('get category from db', () {
    test('get correct category if dbCategory is not null', () async {
      const category = Category.travel;

      final expense = expenseWithoutCategory;
      expense.dbCategory = category.dbIndex;

      expect(expense.category, category);
    });

    test('returns null category if dBCategory is null', () async {
      final expense = expenseWithoutCategory;
      expense.dbCategory = null;

      expect(expense.category, isNull);
    });

    test(
      'returns null category if dbCategory is not known to category enum',
      () async {
        final expense = expenseWithoutCategory;
        expense.dbCategory = 4;

        expect(expense.category, isNull);
      },
    );
  });

  group('set category into db', () {
    test('sets correct dbCategory if category is not null', () async {
      const category = Category.travel;
      final expense = Expense(
        createdAt: DateTime(2025, 2, 28, 20, 38),
        expenseDateTime: DateTime(2025, 2, 28, 20, 38),
        amount: 42.42,
        description: 'description',
        category: category,
      );

      expect(expense.dbCategory, category.dbIndex);
    });

    test('sets null dbCategory if category is null', () async {
      final expense = expenseWithoutCategory;

      expect(expense.dbCategory, isNull);
    });
  });
}
