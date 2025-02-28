import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/state/expense_cubit.dart';
import 'package:expense_tracker/expense/state/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder:
          (context, state) => switch (state) {
            ExpenseEmpty() => const _Empty(),
            ExpenseAdded() => _Added(expense: state.expense),
            ExpenseAddedError() => const _Error(),
          },
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final dummy = Expense(
            createdAt: DateTime.now(),
            amount: 12.98,
            category: Category.travel,
            description: 'description',
          );

          context.read<ExpenseCubit>().add(dummy);
        },
        child: const Text('add dummy'),
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
