import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/mapper/expense_request_mapper.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_write_request.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';

void main() {
  test(
    'given expense write request when mapped then date uses backend format',
    () {
      final request = ExpenseWriteRequest(
        date: DateTime.utc(2026, 6, 30, 13, 44, 0, 999),
        currency: CurrencyCode.pen,
        amount: 28100,
        source: 'BCP_DEBIT_CARD',
        category: 'OCIO',
        comments: 'Mirones',
        recipient: 'PLIN',
      );

      final json = toUpdateExpenseDto(request).toJson();

      expect(json['date'], '2026-06-30T13:44:00Z');
      expect(json['amount'], '281.00');
    },
  );
}
