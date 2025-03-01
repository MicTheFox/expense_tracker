import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseRepository expenseRepository;

  ExpenseCubit({required this.expenseRepository}) : super(ExpenseEmpty());

  void add(Expense expense) async {
    try {
      emit(ExpenseAdding(expense: expense));
      expenseRepository.put(expense);

      emit(ExpenseAdded(expense: expense));
      emit(ExpenseEmpty());
    } catch (_) {
      emit(ExpenseAddedError(expense: expense));
    }
  }
}
