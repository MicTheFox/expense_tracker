import 'dart:collection';

import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense_history/state/expense_history_cubit.dart';
import 'package:expense_tracker/expense_history/state/expense_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseHistoryPage extends StatelessWidget {
  const ExpenseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseHistoryCubit, ExpenseHistoryState>(
      builder:
          (context, state) => switch (state) {
            ExpenseHistoryUnloaded() => const Center(
              child: CircularProgressIndicator(),
            ),
            ExpenseHistoryLoaded() => _Loaded(
              groupedExpenses: state.groupedExpenses,
            ),
            ExpenseHistoryError() => const Center(
              child: Text('An error occured.'),
            ),
          },
    );
  }
}

class _Loaded extends StatelessWidget {
  final UnmodifiableListView<GroupedExpenses> groupedExpenses;
  const _Loaded({required this.groupedExpenses});

  @override
  Widget build(BuildContext context) {
    if (groupedExpenses.isEmpty) {
      return const Center(
        child: Text(
          'Your expenses will show up here after you added your first expense.',
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        for (final group in groupedExpenses) ...[
          SliverToBoxAdapter(child: Text(group.date.toString())),
          SliverList.builder(
            itemCount: group.expenses.length,
            itemBuilder: (context, index) {
              final expense = group.expenses[index];
              return _ExpenseTile(expense: expense);
            },
          ),
        ],
      ],
    );
  }
}

class _ExpenseTile extends StatelessWidget {
  final Expense expense;
  const _ExpenseTile({required this.expense});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.amount.toString()),
      subtitle: Text(expense.description),
      trailing: expense.category == null ? null : Text(expense.category!.name),
    );
  }
}
