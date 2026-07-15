import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/repository/auth_repository.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/repository/expense_repository.dart';

class ExpenseSyncService {
  const ExpenseSyncService(this._auth, this._expenses);

  final AuthRepository _auth;
  final ExpenseRepository _expenses;

  Future<List<String>> syncFromGmail({
    required bool Function() isActive,
  }) async {
    final token = await _auth.requestGmailAccessToken();
    if (!isActive()) throw const CancelledFailure();
    return _expenses.sync(token);
  }
}
