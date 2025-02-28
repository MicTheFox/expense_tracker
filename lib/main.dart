import 'package:expense_tracker/router/router.dart';
import 'package:flutter/material.dart';

import 'local_storage/object_store.dart';

late ObjectBox localStorage;

void main() async {
  localStorage = await ObjectBox.create();

  runApp(const App());
}

class App extends StatelessWidget {
  static const _appName = 'Expense Tracker';

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: _appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
    );
  }
}
