import 'dart:collection';

import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense_history/state/expense_history_cubit.dart';
import 'package:expense_tracker/expense_history/state/expense_history_state.dart';
import 'package:expense_tracker/utils/category_extension.dart';
import 'package:expense_tracker/utils/formatters.dart';
import 'package:expense_tracker/utils/keys.dart';
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
              filter: state.categoryFilter,
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
  final Category? filter;
  final UnmodifiableListView<GroupedExpenses> groupedExpenses;
  const _Loaded({required this.groupedExpenses, required this.filter});

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
        SliverAppBar(
          actions: [
            DropdownButton<Category?>(
              items: [
                ...CategoryExtension.dropdownItems,
                const DropdownMenuItem(child: Text('All categories')),
              ],
              hint: const Text('Category filter'),
              value: filter,
              onChanged: (category) {
                context.read<ExpenseHistoryCubit>().filter(category);
              },
            ),
          ],
        ),
        for (final group in groupedExpenses) ...[
          SliverToBoxAdapter(
            child: _DateHeadline(
              date: group.date,
              totalAmount: group.totalAmount,
            ),
          ),
          SliverList.separated(
            itemCount: group.expenses.length,
            itemBuilder: (context, index) {
              final expense = group.expenses[index];
              return _ExpenseTile(expense: expense);
            },
            separatorBuilder:
                (BuildContext context, int index) =>
                    const Divider(indent: 12, endIndent: 12),
          ),
        ],
      ],
    );
  }
}

class _DateHeadline extends StatelessWidget {
  final DateTime date;
  final double totalAmount;
  const _DateHeadline({required this.date, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: expenseHistoryPageHeadlineKey,
      padding: const EdgeInsets.only(bottom: 8, top: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Row(
          children: [
            Text(
              Formatters.dateFormatter.format(date),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            Text(
              Formatters.currencyFormatter('EUR').format(totalAmount),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpenseTile extends StatelessWidget {
  final Expense expense;
  const _ExpenseTile({required this.expense});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: expenseHistoryPageListTileKey,
      title: Text(
        Formatters.currencyFormatter(expense.currency).format(expense.amount),
      ),
      titleTextStyle: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      subtitle: expense.description.isEmpty ? null : Text(expense.description),
      trailing:
          expense.category == null
              ? null
              : CircleAvatar(child: Icon(expense.category!.icon)),
    );
  }
}
