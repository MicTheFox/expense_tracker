import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense_history/state/expense_history_cubit.dart';
import 'package:expense_tracker/expense_history/state/expense_history_state.dart';
import 'package:expense_tracker/expense_history/widgets/monthly_statistics.dart';
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
            ExpenseHistoryLoaded() => _Loaded(state: state),
            ExpenseHistoryError() => const Center(
              child: Text('An error occured.'),
            ),
          },
    );
  }
}

class _Loaded extends StatelessWidget {
  final ExpenseHistoryLoaded state;
  const _Loaded({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.expenses.isEmpty) {
      return const _Empty();
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: [_CategorySelector(filter: state.categoryFilter)],
        ),
        SliverToBoxAdapter(
          child: MonthlyStatistics(
            monthlyAmountsOfLastYear: state.monthlyAmountsOfLastYear,
          ),
        ),
        for (final group in state.groupedExpenses) ...[
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

class _CategorySelector extends StatelessWidget {
  final Category? filter;
  const _CategorySelector({this.filter});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category?>(
      underline: const SizedBox(),
      padding: const EdgeInsets.only(bottom: 6),
      items: [
        ...CategoryExtension.dropdownItems,
        const DropdownMenuItem(child: Text('All categories')),
      ],
      hint: const Text('Category filter'),
      value: filter,
      onChanged: (category) {
        context.read<ExpenseHistoryCubit>().filter(category);
      },
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(
        key: expenseHistoryPageEmptyKey,
        child: Text(
          'Your expenses will show up here after you added your first expense.',
          textAlign: TextAlign.center,
        ),
      ),
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
              : CircleAvatar(child: Icon(expense.category!.icon, size: 16)),
    );
  }
}
