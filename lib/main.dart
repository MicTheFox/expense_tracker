import 'package:expense_tracker/expense/repository/expense_repository.dart';
import 'package:expense_tracker/expense/repository/local_expense_repository.dart';
import 'package:expense_tracker/router/router.dart';
import 'package:flutter/material.dart';

import 'expense/data_models/expense.dart';
import 'local_storage/object_store.dart';

void main() async {
  final localStorage = await ObjectStore.create();
  final expenseRepository = LocalExpenseRepository(
    db: localStorage.store.box<Expense>(),
  );

  runApp(App(expenseRepository: expenseRepository));
}

class App extends StatelessWidget {
  static const _appName = 'Expense Tracker';

  final ExpenseRepository expenseRepository;

  const App({super.key, required this.expenseRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router(expenseRepository),
      title: _appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
    );
  }
}
