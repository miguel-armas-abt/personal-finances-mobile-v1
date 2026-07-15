import 'package:finances_api/finances_api.dart';
import 'package:personal_finances_mobile_v1/commons/network/api_client.dart';
import 'package:personal_finances_mobile_v1/commons/utils/decimal_amount.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/repository/expense_repository.dart';

ExpensePageResult mapExpensePage(ExpenseSearchResponseDto dto) =>
    ExpensePageResult(
      expenses: List.unmodifiable(
        requireValue(dto.expenses, 'expenses').map(_mapExpense),
      ),
      nextCursor: dto.nextCursor,
    );

Expense _mapExpense(ExpenseResponseDto dto) {
  final detail = requireValue(dto.detail, 'detail');
  return Expense(
    id: requireValue(dto.id, 'expense ID'),
    gmailMessageId: dto.gmailMessageId,
    date: requireValue(dto.date?.utc, 'expense date').toLocal(),
    formattedDate: dto.date?.formatted ?? '',
    money: Money(
      amount: parseMinorUnits(requireValue(dto.amount, 'amount')),
      currency: CurrencyCode.fromCode(
        requireValue(dto.currency?.code, 'currency'),
      ),
    ),
    source: requireValue(detail.source_, 'source'),
    category: detail.category,
    comments: detail.comments,
    recipient: detail.recipient,
  );
}
