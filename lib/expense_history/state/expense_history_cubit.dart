import 'dart:collection';

import 'package:expense_tracker/expense/repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'expense_history_state.dart';

class ExpenseHistoryCubit extends Cubit<ExpenseHistoryState> {
  final ExpenseRepository expenseRepository;

  ExpenseHistoryCubit({required this.expenseRepository})
    : super(ExpenseHistoryUnloaded());

  void load() async {
    try {
      final expenses = await expenseRepository.getAll();
      emit(ExpenseHistoryLoaded(expenses: UnmodifiableListView(expenses)));
    } catch (_) {
      emit(ExpenseHistoryError());
    }
  }
}
