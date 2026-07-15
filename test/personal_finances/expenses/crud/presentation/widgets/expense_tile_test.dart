import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/widgets/expense_tile.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('es_PE');
  });

  testWidgets('given edit action when pressed then edit callback runs', (
    tester,
  ) async {
    var editWasSelected = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExpenseTile(
            expense: _expense(),
            onEdit: () => editWasSelected = true,
            onDelete: () {},
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Editar'));
    await tester.pump();

    expect(editWasSelected, isTrue);
  });
}

Expense _expense() {
  return Expense(
    id: 'expense-id',
    date: DateTime(2026, 6, 30, 13, 44),
    formattedDate: '30 jun 2026',
    money: const Money(amount: 28000, currency: CurrencyCode.pen),
    source: 'BCP_DEBIT_CARD',
    recipient: 'PLIN',
    category: 'Transferencias',
    comments: 'Pago',
  );
}
