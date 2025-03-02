import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/state/expense_cubit.dart';
import 'package:expense_tracker/expense/state/expense_state.dart';
import 'package:expense_tracker/expense/widgets/add_expense_form.dart';
import 'package:expense_tracker/utils/keys.dart';
import 'package:expense_tracker/utils/string_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        spacing: 16,
        children: [
          Text(
            'Add expense',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          BlocConsumer<ExpenseCubit, ExpenseState>(
            listener: (context, state) {
              switch (state) {
                case ExpenseEmpty() || ExpenseAdding():
                  return;
                case ExpenseAdded():
                  final expense = state.expense;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(_addedSnackBar(expense));
                  return;
                case ExpenseAddedError():
                  ScaffoldMessenger.of(context).showSnackBar(_errorSnackBar());
                  return;
              }
            },
            builder:
                (context, state) => switch (state) {
                  ExpenseEmpty() ||
                  ExpenseAddedError() ||
                  ExpenseAdded() => const AddExpenseForm(isLoading: false),
                  ExpenseAdding() => const AddExpenseForm(isLoading: true),
                },
          ),
        ],
      ),
    );
  }

  SnackBar _addedSnackBar(Expense expense) => SnackBar(
    key: addExpensePageAddedKey,
    content: Text(
      'Expense with amount ${StringFormatters.currencyFormatter(expense.currency).format(expense.amount)} was added.',
    ),
  );

  SnackBar _errorSnackBar() => const SnackBar(
    key: addExpensePageErrorKey,
    content: Text('An error occurred'),
  );
}
