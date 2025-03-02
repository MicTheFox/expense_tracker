import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/repository/expense_repository.dart';
import 'package:expense_tracker/expense/repository/local_expense_repository.dart';
import 'package:expense_tracker/local_storage/object_store.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/utils/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/intl.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late final ExpenseRepository expenseRepository;

  final amountField = find.byKey(addExpenseFormAmountTextFieldKey);
  final submitButton = find.byKey(addExpenseFormSubmitButtonKey);

  setUpAll(() async {
    final localStorage = await ObjectStore.create(isInMemory: true);
    expenseRepository = LocalExpenseRepository(
      db: localStorage.store.box<Expense>(),
    );
  });

  testWidgets('adding an expense adds it to the history list', (tester) async {
    await tester.pumpWidget(App(expenseRepository: expenseRepository));

    await tester.enterText(amountField, '42');
    await tester.pumpAndSettle();

    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(navigationHistoryKey));
    await tester.pumpAndSettle();

    expect(find.byKey(expenseHistoryPageListTileKey), findsOneWidget);
  });

  testWidgets(
    'adding a second expenses for a different month shows statistics and 2 '
    'history page tiles',
    (tester) async {
      await tester.pumpWidget(App(expenseRepository: expenseRepository));

      await tester.enterText(amountField, '21');
      await tester.pumpAndSettle();

      final inThePast = DateTime.now().subtract(const Duration(days: 60));
      await tester.enterText(
        find.byKey(addExpenseFormDateTimeTextFieldKey),
        DateFormat('dd/MM/yyyy').format(inThePast),
      );

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(navigationHistoryKey));
      await tester.pumpAndSettle();

      expect(find.text('Monthly statistics'), findsOneWidget);
      expect(find.byKey(expenseHistoryPageListTileKey), findsNWidgets(2));
    },
  );
}
