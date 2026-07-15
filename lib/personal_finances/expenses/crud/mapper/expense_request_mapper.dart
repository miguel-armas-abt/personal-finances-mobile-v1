import 'package:finances_api/finances_api.dart';
import 'package:personal_finances_mobile_v1/commons/network/api_client.dart';
import 'package:personal_finances_mobile_v1/commons/utils/backend_date_time_format.dart';
import 'package:personal_finances_mobile_v1/commons/utils/decimal_amount.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_write_request.dart';

ExpenseSaveRequestDto toSaveExpenseDto(ExpenseWriteRequest request) =>
    ExpenseSaveRequestDto(
      userEmail: requireValue(request.userEmail, 'user email'),
      gmailMessageId: request.gmailMessageId,
      date: formatBackendUtcDateTime(request.date),
      currency: request.currency.code,
      amount: formatMinorUnits(request.amount),
      detail: ExpenseSaveDetail(
        source_: request.source.trim(),
        category: optionalText(request.category),
        comments: optionalText(request.comments),
        recipient: optionalText(request.recipient),
      ),
    );

ExpenseUpdateRequestDto toUpdateExpenseDto(ExpenseWriteRequest request) =>
    ExpenseUpdateRequestDto(
      date: formatBackendUtcDateTime(request.date),
      currency: request.currency.code,
      amount: formatMinorUnits(request.amount),
      detail: ExpenseUpdateDetail(
        category: request.category.trim(),
        comments: request.comments.trim(),
        recipient: optionalText(request.recipient),
      ),
    );

String? optionalText(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}
