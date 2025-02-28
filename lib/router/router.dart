import 'package:expense_tracker/expense/repository/expense_repository.dart';
import 'package:expense_tracker/expense/state/expense_cubit.dart';
import 'package:expense_tracker/expense/widgets/add_expense_page.dart';
import 'package:expense_tracker/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/add-expense',
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteNames.addExpenseRouteName,
              path: '/add-expense',
              builder: (_, __) => const AddExpensePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteNames.historyRouteName,
              path: '/history',
              builder: (_, __) => const Placeholder(),
            ),
          ],
        ),
      ],
      builder:
          (context, state, navigationShell) => BlocProvider(
            create:
                (context) =>
                    ExpenseCubit(expenseRepository: ExpenseRepository()),
            child: _Shell(navigationShell: navigationShell),
          ),
    ),
  ],
);

class _Shell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _Shell({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.add), label: 'Add'),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
      body: navigationShell,
    );
  }
}
