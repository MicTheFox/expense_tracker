import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseRepository expenseRepository;

  ExpenseCubit({required this.expenseRepository}) : super(ExpenseEmpty());

  void add(Expense expense) async {
    try {
      expenseRepository.put(expense);

      emit(ExpenseAdded(expense: expense));
    } catch (_) {
      emit(ExpenseAddedError(expense: expense));
    }
  }
}
