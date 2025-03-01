import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/state/expense_cubit.dart';
import 'package:expense_tracker/expense/state/expense_state.dart';
import 'package:expense_tracker/expense/widgets/add_expense_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder:
            (context, state) => switch (state) {
              ExpenseEmpty() => AddExpenseForm(isLoading: false),
              ExpenseAdding() => AddExpenseForm(isLoading: true),
              ExpenseAdded() => _Added(expense: state.expense),
              ExpenseAddedError() => const _Error(),
            },
      ),
    );
  }
}

class _Added extends StatelessWidget {
  final Expense expense;
  const _Added({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(expense.toString()));
  }
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('An error occured'));
  }
}
