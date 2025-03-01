import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/state/expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseForm extends StatefulWidget {
  final bool isLoading;
  const AddExpenseForm({super.key, required this.isLoading});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();

  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime _expenseDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
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
          InputDatePickerFormField(
            initialDate: _expenseDateTime,
            firstDate: now.subtract(const Duration(days: 365)),
            lastDate: now,
            onDateSaved: (date) => _expenseDateTime = date,
          ),
          ElevatedButton(
            onPressed:
                widget.isLoading
                    ? null
                    : () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
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
                widget.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
