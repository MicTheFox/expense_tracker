import 'dart:collection';

import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/expense/repository/expense_repository.dart';
import 'package:expense_tracker/expense_history/state/expense_history_cubit.dart';
import 'package:expense_tracker/expense_history/state/expense_history_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../expense_test_factory.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

void main() {
  late final ExpenseRepository mockExpenseRepository;

  final expenses = [
    ExpenseTestFactory.expenseWithoutCategory,
    ExpenseTestFactory.expenseFirstMarch,
    ExpenseTestFactory.expense28thFebruary,
    ExpenseTestFactory.expenseSecondMarch,
  ];

  setUpAll(() {
    mockExpenseRepository = MockExpenseRepository();
  });

  blocTest(
    'emits [ExpenseHistoryLoaded] when repository returns with success',
    build: () => ExpenseHistoryCubit(expenseRepository: mockExpenseRepository),
    setUp: () {
      when(
        () => mockExpenseRepository.getAll(),
      ).thenAnswer((_) => Future.value(expenses));
    },
    act: (cubit) => cubit.load(),
    expect:
        () => [ExpenseHistoryLoaded(expenses: UnmodifiableListView(expenses))],
  );

  blocTest(
    'emits [ExpenseHistoryError] when expenseRepository throws',
    build: () => ExpenseHistoryCubit(expenseRepository: mockExpenseRepository),
    setUp: () {
      when(() => mockExpenseRepository.getAll()).thenThrow(Exception());
    },
    act: (cubit) => cubit.load(),
    expect: () => [ExpenseHistoryError()],
  );
}
