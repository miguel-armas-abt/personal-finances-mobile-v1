import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finances_mobile_v1/commons/theme/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/widgets/expense_tile.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('es_PE');
  });

  test('given a comment when choosing a title then it takes priority', () {
    expect(expenseTitle(_expense(comment: '  Pago  ')), 'Pago');
    expect(expenseTitle(_expense(comment: '   ')), 'PLIN');
  });
  testWidgets('given an expense when its row is pressed then detail opens', (
    tester,
  ) async {
    var detailOpened = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: ExpenseTile(
            expense: _expense(),
            onOpen: () => detailOpened = true,
          ),
        ),
      ),
    );

    final title = tester.widget<Text>(find.text('PLIN'));
    expect(title.style?.color, AppTheme.ink);
    expect(find.text('−S/ 280.00'), findsOneWidget);

    await tester.tap(find.text('PLIN'));
    await tester.pump();

    expect(detailOpened, isTrue);
  });
}

Expense _expense({String? comment}) {
  return Expense(
    id: 'expense-id',
    date: DateTime(2026, 6, 30, 13, 44),
    formattedDate: '30 jun 2026',
    money: const Money(amount: 28000, currency: CurrencyCode.pen),
    source: 'BCP_DEBIT_CARD',
    recipient: 'PLIN',
    category: 'Transferencias',
    comments: comment,
  );
}
