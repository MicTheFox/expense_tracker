import 'dart:async';
import 'dart:collection';

import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/repository/expense_repository.dart';
import 'package:expense_tracker/expense_history/state/expense_history_cubit.dart';
import 'package:expense_tracker/expense_history/state/expense_history_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../expense_test_factory.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

void main() {
  late final ExpenseRepository mockExpenseRepository;
  late final StreamController<Expense> mockExpenseUpdateStream;

  final expenses = [
    ExpenseTestFactory.expenseWithoutCategory,
    ExpenseTestFactory.expenseFirstMarch,
    ExpenseTestFactory.expense28thFebruary,
    ExpenseTestFactory.expenseSecondMarch,
  ];

  setUpAll(() {
    mockExpenseRepository = MockExpenseRepository();
    mockExpenseUpdateStream = StreamController<Expense>.broadcast();
    when(
      () => mockExpenseRepository.expenseUpdates,
    ).thenAnswer((_) => mockExpenseUpdateStream.stream);
  });

  tearDownAll(() {
    mockExpenseUpdateStream.close();
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

  blocTest(
    'emits updated[ExpenseHistoryLoaded] after receiving event from expense updated stream',
    seed:
        () => ExpenseHistoryLoaded(
          expenses: UnmodifiableListView([
            ExpenseTestFactory.expenseWithoutCategory,
          ]),
        ),
    build: () => ExpenseHistoryCubit(expenseRepository: mockExpenseRepository),
    setUp: () {
      when(
        () => mockExpenseRepository.put(ExpenseTestFactory.expenseFirstMarch),
      ).thenAnswer((_) {
        mockExpenseUpdateStream.add(ExpenseTestFactory.expenseFirstMarch);
        return Future.value(2);
      });
    },
    act:
        (cubit) =>
            mockExpenseRepository.put(ExpenseTestFactory.expenseFirstMarch),
    expect:
        () => [
          ExpenseHistoryLoaded(
            expenses: UnmodifiableListView([
              ExpenseTestFactory.expenseWithoutCategory,
              ExpenseTestFactory.expenseFirstMarch,
            ]),
          ),
        ],
  );
}
