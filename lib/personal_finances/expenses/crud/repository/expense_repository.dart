import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_search_criteria.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_write_request.dart';

class ExpensePageResult {
  const ExpensePageResult({
    required this.expenses,
    this.nextCursor,
    this.omittedCount = 0,
  });

  final List<Expense> expenses;
  final String? nextCursor;
  final int omittedCount;
}

abstract interface class ExpenseRepository {
  Future<ExpensePageResult> search({
    required ExpenseSearchCriteria criteria,
    String? encodedCursor,
  });

  Future<String> create(ExpenseWriteRequest request);

  Future<void> update({
    required String expenseId,
    required ExpenseWriteRequest request,
  });

  Future<void> delete(String expenseId);

  Future<List<String>> sync(String gmailAccessToken);
}
