import 'dart:collection';

import 'package:expense_tracker/utils/formatters.dart';
import 'package:flutter/material.dart';

class MonthlyStatistics extends StatelessWidget {
  final UnmodifiableListView<(DateTime, double)> monthlyAmountsOfLastYear;
  const MonthlyStatistics({super.key, required this.monthlyAmountsOfLastYear});

  @override
  Widget build(BuildContext context) {
    final total = monthlyAmountsOfLastYear.fold(
      0.0,
      (current, element) => current + element.$2,
    );
    return ExpansionTile(
      collapsedBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      title: Text(
        'Monthly statistics',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      children:
          monthlyAmountsOfLastYear
              .map(
                (monthlyAmount) => _MonthTile(
                  monthlyAmount: monthlyAmount,
                  totalAmount: total,
                ),
              )
              .toList(),
    );
  }
}

class _MonthTile extends StatelessWidget {
  final (DateTime, double) monthlyAmount;
  final double totalAmount;
  const _MonthTile({required this.monthlyAmount, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text(Formatters.monthFormatter.format(monthlyAmount.$1)),
              const Spacer(),
              Text(
                Formatters.currencyFormatter('EUR').format(monthlyAmount.$2),
              ),
            ],
          ),
          LinearProgressIndicator(
            value: monthlyAmount.$2 / totalAmount,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        ],
      ),
    );
  }
}
