import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/state/expense_cubit.dart';
import 'package:expense_tracker/utils/category_extension.dart';
import 'package:expense_tracker/utils/keys.dart';
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
  Category? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Form(
      key: _formKey,
      child: Column(
        spacing: 32,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FormFieldCard(
            children: [
              DropdownButtonFormField(
                hint: const Text('Choose a category (optional)'),
                items: CategoryExtension.dropdownItems,
                value: _selectedCategory,
                onChanged: (newSelection) {
                  setState(() {
                    _selectedCategory = newSelection;
                  });
                },
              ),
              TextFormField(
                key: addExpenseFormAmountTextFieldKey,
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  suffixIcon: Icon(Icons.euro),
                ),
                validator: _amountValidator,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: InputDatePickerFormField(
                  initialDate: _expenseDateTime,
                  firstDate: now.subtract(const Duration(days: 365)),
                  lastDate: now,
                  onDateSaved: (date) => _expenseDateTime = date,
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          FilledButton(
            key: addExpenseFormSubmitButtonKey,
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
                          category: _selectedCategory,
                        );

                        context.read<ExpenseCubit>().add(expense);
                      }
                    },
            child:
                widget.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Add'),
          ),
        ],
      ),
    );
  }

  String? _amountValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some amount';
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid amount';
    }

    return null;
  }
}

class _FormFieldCard extends StatelessWidget {
  final List<Widget> children;
  const _FormFieldCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(spacing: 32, children: children),
      ),
    );
  }
}
