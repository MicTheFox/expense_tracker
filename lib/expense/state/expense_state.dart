import 'package:equatable/equatable.dart';
import 'package:expense_tracker/expense/data_models/expense.dart';

sealed class ExpenseState extends Equatable {}

final class ExpenseEmpty extends ExpenseState {
  @override
  List<Object?> get props => [];
}

final class ExpenseAdding extends ExpenseState {
  final Expense expense;

  ExpenseAdding({required this.expense});

  @override
  List<Object?> get props => [expense];
}

final class ExpenseAdded extends ExpenseState {
  final Expense expense;

  ExpenseAdded({required this.expense});

  @override
  List<Object?> get props => [expense];
}

final class ExpenseAddedError extends ExpenseState {
  final Expense expense;

  ExpenseAddedError({required this.expense});

  @override
  List<Object?> get props => [expense];
}
