import 'package:expense_tracker/expense/data_models/expense.dart';
import 'package:expense_tracker/expense/repository/local_expense_repository.dart';
import 'package:expense_tracker/local_storage/object_store.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/utils/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('adding an expense adds it to the history list', (tester) async {
    final localStorage = await ObjectStore.create();
    final expenseRepository = LocalExpenseRepository(
      db: localStorage.store.box<Expense>(),
    );

    await tester.pumpWidget(App(expenseRepository: expenseRepository));

    final amountField = find.byKey(addExpenseFormAmountTextFieldKey);
    await tester.enterText(amountField, '42');
    await tester.pumpAndSettle();

    final submitButton = find.byKey(addExpenseFormSubmitButtonKey);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(navigationHistoryKey));
    await tester.pumpAndSettle();

    expect(find.byKey(expenseHistoryPageListTileKey), findsOneWidget);
  });
}
