import 'dart:convert';

import 'package:finances_api/finances_api.dart';
import 'package:personal_finances_mobile_v1/commons/logging/app_logger.dart';
import 'package:personal_finances_mobile_v1/commons/network/api_client.dart';
import 'package:personal_finances_mobile_v1/commons/utils/backend_date_time_format.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/mapper/expense_request_mapper.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/mapper/expense_response_mapper.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_search_criteria.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_write_request.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/repository/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  ExpenseRepositoryImpl(this._transport)
    : _api = FinancesApi(dio: _transport.dio).getExpenseApi();

  final ApiTransport _transport;
  final ExpenseApi _api;

  @override
  Future<ExpensePageResult> search({
    required ExpenseSearchCriteria criteria,
    String? encodedCursor,
  }) => _transport.run(() async {
    final trace = _transport.trace();
    final response = await _api.searchExpenses(
      authorization: await _transport.authorization(),
      callerName: _transport.callerName,
      traceParent: trace,
      extra: _transport.operation('searchExpenses'),
      recipient: optionalText(criteria.recipient),
      category: optionalText(criteria.category),
      currency: optionalText(criteria.currency),
      from: criteria.from == null
          ? null
          : formatBackendUtcDateTime(criteria.from!),
      to: criteria.to == null ? null : formatBackendUtcDateTime(criteria.to!),
      encodedCursor: optionalText(encodedCursor),
    );
    return mapExpensePage(
      requireValue(response.data, 'expense page'),
      onInvalidExpense: (index, error) {
        AppLogger.warning(
          jsonEncode({
            'event': 'expenses.invalidRecord',
            'traceId': trace.split('-')[1],
            'index': index,
            'reason': error.message,
          }),
          name: 'app.expenses',
        );
      },
    );
  });

  @override
  Future<String> create(ExpenseWriteRequest request) =>
      _transport.run(() async {
        final response = await _api.saveExpense(
          authorization: await _transport.authorization(),
          callerName: _transport.callerName,
          traceParent: _transport.trace(),
          extra: _transport.operation('saveExpense'),
          expenseSaveRequestDto: toSaveExpenseDto(request),
        );
        return requireValue(response.data?.expenseId, 'expense ID');
      });

  @override
  Future<void> update({
    required String expenseId,
    required ExpenseWriteRequest request,
  }) => _transport.run(() async {
    await _api.updateExpense(
      authorization: await _transport.authorization(),
      callerName: _transport.callerName,
      traceParent: _transport.trace(),
      extra: _transport.operation('updateExpense'),
      expenseId: expenseId,
      expenseUpdateRequestDto: toUpdateExpenseDto(request),
    );
  });

  @override
  Future<void> delete(String expenseId) => _transport.run(() async {
    await _api.deleteExpense(
      authorization: await _transport.authorization(),
      callerName: _transport.callerName,
      traceParent: _transport.trace(),
      extra: _transport.operation('deleteExpense'),
      expenseId: expenseId,
    );
  });

  @override
  Future<List<String>> sync(String gmailAccessToken) =>
      _transport.run(() async {
        final response = await _api.syncExpenses(
          authorization: await _transport.authorization(),
          callerName: _transport.callerName,
          traceParent: _transport.trace(),
          extra: _transport.operation('syncExpenses'),
          gmailAccessToken: gmailAccessToken,
        );
        if (response.statusCode == 204) return const [];
        return List.unmodifiable(
          requireValue(response.data?.gmailMessageIds, 'synced IDs'),
        );
      });
}
