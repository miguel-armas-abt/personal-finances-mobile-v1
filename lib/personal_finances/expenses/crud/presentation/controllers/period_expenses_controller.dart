import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finances_mobile_v1/app/dependencies.dart';
import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_search_criteria.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/repository/expense_repository.dart';

final expenseDataRevisionProvider =
    NotifierProvider<ExpenseDataRevisionController, int>(
      ExpenseDataRevisionController.new,
    );

class ExpenseDataRevisionController extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;
}

final calendarExpensesControllerProvider =
    NotifierProvider.autoDispose<PeriodExpensesController, PeriodExpensesState>(
      PeriodExpensesController.new,
    );

final analysisExpensesControllerProvider =
    NotifierProvider.autoDispose<PeriodExpensesController, PeriodExpensesState>(
      PeriodExpensesController.new,
    );

class PeriodExpensesState {
  const PeriodExpensesState({
    this.expenses = const [],
    this.isLoading = false,
    this.loadError,
  });

  final List<Expense> expenses;
  final bool isLoading;
  final String? loadError;
}

class PeriodExpensesController extends Notifier<PeriodExpensesState> {
  int _generation = 0;

  ExpenseRepository get _repository => ref.read(expenseRepositoryProvider);

  @override
  PeriodExpensesState build() => const PeriodExpensesState();

  Future<void> load(ExpenseSearchCriteria criteria) async {
    final generation = ++_generation;
    state = const PeriodExpensesState(isLoading: true);
    try {
      final expensesById = <String, Expense>{};
      final seenCursors = <String>{};
      String? cursor;

      while (true) {
        final page = await _repository.search(
          criteria: criteria,
          encodedCursor: cursor,
        );
        if (!ref.mounted || generation != _generation) return;
        for (final expense in page.expenses) {
          expensesById[expense.id] = expense;
        }

        final nextCursor = page.nextCursor;
        if (nextCursor == null ||
            nextCursor.isEmpty ||
            nextCursor == cursor ||
            !seenCursors.add(nextCursor)) {
          break;
        }
        cursor = nextCursor;
      }

      if (!ref.mounted || generation != _generation) return;
      state = PeriodExpensesState(
        expenses: List.unmodifiable(expensesById.values),
      );
    } on AppFailure catch (failure) {
      if (!ref.mounted || generation != _generation) return;
      state = PeriodExpensesState(loadError: failure.message);
    }
  }
}
