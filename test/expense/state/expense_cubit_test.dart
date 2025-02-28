import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/expense/repository/expense_repository.dart';
import 'package:expense_tracker/expense/state/expense_cubit.dart';
import 'package:expense_tracker/expense/state/expense_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../expense_test_factory.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

void main() {
  late final ExpenseRepository mockExpenseRepository;

  final expenseWithoutCategory = ExpenseTestFactory.expenseWithoutCategory;

  setUpAll(() {
    mockExpenseRepository = MockExpenseRepository();
  });

  blocTest(
    'emits [ExpenseAdded] when expense is added successfully',
    build: () => ExpenseCubit(expenseRepository: mockExpenseRepository),
    setUp: () {
      when(
        () => mockExpenseRepository.put(expenseWithoutCategory),
      ).thenAnswer((_) => Future.value(1));
    },
    act: (cubit) => cubit.add(expenseWithoutCategory),
    expect: () => [ExpenseAdded(expense: expenseWithoutCategory)],
  );

  blocTest(
    'emits [ExpenseAddedError] when expenseRepository throws in put attempt',
    build: () => ExpenseCubit(expenseRepository: mockExpenseRepository),
    setUp: () {
      when(
        () => mockExpenseRepository.put(expenseWithoutCategory),
      ).thenThrow(Exception());
    },
    act: (cubit) => cubit.add(expenseWithoutCategory),
    expect: () => [ExpenseAddedError(expense: expenseWithoutCategory)],
  );
}
