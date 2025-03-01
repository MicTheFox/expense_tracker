import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/state/expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseForm extends StatelessWidget {
  final bool isLoading;
  AddExpenseForm({super.key, required this.isLoading});

  final _formKey = GlobalKey<FormState>();

  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final DateTime _expenseDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some amount';
              }

              final amount = double.tryParse(value);
              if (amount == null) {
                return 'Please enter a valid amount';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          ElevatedButton(
            onPressed:
                isLoading
                    ? null
                    : () {
                      if (_formKey.currentState!.validate()) {
                        final expense = Expense(
                          createdAt: DateTime.now(),
                          expenseDateTime: _expenseDateTime,
                          amount: double.parse(_amountController.text),
                          description: _descriptionController.text,
                        );

                        context.read<ExpenseCubit>().add(expense);
                      }
                    },
            child:
                isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
