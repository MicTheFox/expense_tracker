import 'dart:async';
import 'dart:collection';

import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'expense_history_state.dart';

class ExpenseHistoryCubit extends Cubit<ExpenseHistoryState> {
  final ExpenseRepository expenseRepository;

  late final StreamSubscription<Expense> _expenseUpdateSubscription;

  ExpenseHistoryCubit({required this.expenseRepository})
    : super(ExpenseHistoryUnloaded()) {
    _expenseUpdateSubscription = expenseRepository.expenseUpdates.listen(
      _onExpenseUpdate,
    );
  }

  @override
  Future<void> close() {
    _expenseUpdateSubscription.cancel();
    return super.close();
  }

  void _onExpenseUpdate(Expense expense) {
    final state = this.state;
    switch (state) {
      case ExpenseHistoryUnloaded() || ExpenseHistoryError():
        load();
        return;
      case ExpenseHistoryLoaded():
        emit(
          ExpenseHistoryLoaded(
            expenses: UnmodifiableListView([expense, ...state.expenses]),
          ),
        );
    }
  }

  void load() async {
    try {
      final expenses = await expenseRepository.getAll();
      emit(ExpenseHistoryLoaded(expenses: UnmodifiableListView(expenses)));
    } catch (_) {
      emit(ExpenseHistoryError());
    }
  }

  void filter(Category? category) async {
    final state = this.state;
    switch (state) {
      case ExpenseHistoryUnloaded() || ExpenseHistoryError():
        return;
      case ExpenseHistoryLoaded():
        emit(
          ExpenseHistoryLoaded(
            expenses: state.expenses,
            categoryFilter: category,
          ),
        );
    }
  }
}
