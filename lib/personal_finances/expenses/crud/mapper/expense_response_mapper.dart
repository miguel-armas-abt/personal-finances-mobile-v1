import 'package:finances_api/finances_api.dart';
import 'package:personal_finances_mobile_v1/commons/network/api_client.dart';
import 'package:personal_finances_mobile_v1/commons/utils/decimal_amount.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/repository/expense_repository.dart';

ExpensePageResult mapExpensePage(
  ExpenseSearchResponseDto dto, {
  required void Function(int index, FormatException error) onInvalidExpense,
}) {
  final rows = requireValue(dto.expenses, 'expenses');
  final expenses = <Expense>[];
  for (final (index, row) in rows.indexed) {
    try {
      expenses.add(_mapExpense(row));
    } on FormatException catch (error) {
      onInvalidExpense(index, error);
    }
  }
  final omittedCount = rows.length - expenses.length;
  if (omittedCount > 0 && expenses.isEmpty) {
    throw const FormatException('No valid expenses in page');
  }
  return ExpensePageResult(
    expenses: List.unmodifiable(expenses),
    nextCursor: dto.nextCursor,
    omittedCount: omittedCount,
  );
}

Expense _mapExpense(ExpenseResponseDto dto) {
  final detail = requireValue(dto.detail, 'detail');
  return Expense(
    id: requireValue(dto.id, 'expense ID'),
    gmailMessageId: dto.gmailMessageId,
    date: requireValue(dto.date?.utc, 'expense date').toLocal(),
    formattedDate: dto.date?.formatted ?? '',
    money: Money(
      amount: parseMinorUnits(requireValue(dto.amount, 'amount')),
      currency: CurrencyCode.fromCode(dto.currency?.code),
    ),
    source: requireValue(detail.source_, 'source'),
    category: detail.category,
    comments: detail.comments,
    recipient: detail.recipient,
  );
}
