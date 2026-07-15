import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:personal_finances_mobile_v1/app/app.dart';
import 'package:personal_finances_mobile_v1/app/dependencies.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/model/auth_user.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/model/user_session.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/repository/auth_repository.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_search_criteria.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_write_request.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/repository/expense_repository.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('es_PE');
  });

  testWidgets('given an expense when edit is selected then edit form opens', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(_FakeAuthRepository()),
          expenseRepositoryProvider.overrideWithValue(_FakeExpenseRepository()),
        ],
        child: const PersonalFinancesApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump();

    expect(find.text('PLIN'), findsOneWidget);

    await tester.tap(find.byTooltip('Editar'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Editar gasto'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '280.00'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<String> requestGmailAccessToken() async {
    return 'gmail-token';
  }

  @override
  Future<UserSession?> restoreSession() async {
    return const UserSession(
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
      expiresIn: 1800,
      user: AuthUser(
        id: 'user-id',
        email: 'user@example.com',
        fullName: 'User Example',
        plan: 'FREE',
        gmailConnected: true,
      ),
    );
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<UserSession> signInWithGoogle() async {
    final session = await restoreSession();
    return session!;
  }
}

class _FakeExpenseRepository implements ExpenseRepository {
  @override
  Future<String> create(ExpenseWriteRequest request) async {
    return 'expense-id';
  }

  @override
  Future<void> delete(String expenseId) async {}

  @override
  Future<ExpensePageResult> search({
    required ExpenseSearchCriteria criteria,
    String? encodedCursor,
  }) async {
    return ExpensePageResult(expenses: [_expense()]);
  }

  @override
  Future<List<String>> sync(String gmailAccessToken) async {
    return const [];
  }

  @override
  Future<void> update({
    required String expenseId,
    required ExpenseWriteRequest request,
  }) async {}
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
