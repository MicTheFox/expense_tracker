import 'package:expense_tracker/router/routeNames.dart';
import 'package:flutter/material.dart';
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
              builder: (_, __) => const Placeholder(),
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
          (context, state, navigationShell) =>
              _Shell(navigationShell: navigationShell),
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
