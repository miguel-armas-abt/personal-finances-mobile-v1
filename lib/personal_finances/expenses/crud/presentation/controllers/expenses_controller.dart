import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';
import 'package:personal_finances_mobile_v1/app/dependencies.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_search_criteria.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_write_request.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/repository/expense_repository.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/controllers/expenses_state.dart';

final expensesControllerProvider =
    NotifierProvider.autoDispose<ExpensesController, ExpensesState>(
      ExpensesController.new,
    );

class ExpensesController extends Notifier<ExpensesState> {
  int _searchGeneration = 0;
  bool _mutating = false;

  ExpenseRepository get _repository => ref.read(expenseRepositoryProvider);

  @override
  ExpensesState build() {
    Future<void>.microtask(() async {
      if (ref.mounted && _searchGeneration == 0) await loadFirstPage();
    });
    return const ExpensesState.initial();
  }

  Future<void> loadFirstPage({ExpenseSearchCriteria? criteria}) async {
    final generation = ++_searchGeneration;
    final nextCriteria = criteria ?? state.criteria;
    state = state.copyWith(
      criteria: nextCriteria,
      expenses: criteria == null ? null : const [],
      omittedCount: criteria == null ? null : 0,
      clearLoadError: true,
      isLoading: true,
      clearMessage: true,
      clearCursor: true,
      isLoadingMore: false,
    );
    try {
      final page = await _repository.search(criteria: nextCriteria);
      if (!ref.mounted || generation != _searchGeneration) return;
      state = state.copyWith(
        expenses: page.expenses,
        omittedCount: page.omittedCount,
        nextCursor: page.nextCursor,
        isLoading: false,
      );
    } on AppFailure catch (failure) {
      if (!ref.mounted || generation != _searchGeneration) return;
      state = state.copyWith(isLoading: false, loadError: failure.message);
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoading || state.isLoadingMore) {
      return;
    }
    final generation = _searchGeneration;
    final cursor = state.nextCursor;
    state = state.copyWith(isLoadingMore: true, clearMessage: true);
    try {
      final page = await _repository.search(
        criteria: state.criteria,
        encodedCursor: cursor,
      );
      if (!ref.mounted || generation != _searchGeneration) return;
      final byId = {
        for (final item in [...state.expenses, ...page.expenses]) item.id: item,
      };
      state = state.copyWith(
        expenses: List.unmodifiable(byId.values),
        omittedCount: state.omittedCount + page.omittedCount,
        nextCursor: page.nextCursor,
        clearCursor: page.nextCursor == null || page.nextCursor == cursor,
        isLoadingMore: false,
      );
    } on AppFailure catch (failure) {
      if (!ref.mounted || generation != _searchGeneration) return;
      state = state.copyWith(isLoadingMore: false, message: failure.message);
    }
  }

  Future<bool> create(ExpenseWriteRequest request) =>
      _mutate(() => _repository.create(request));

  Future<bool> update({
    required String expenseId,
    required ExpenseWriteRequest request,
  }) =>
      _mutate(() => _repository.update(expenseId: expenseId, request: request));

  Future<bool> delete(String expenseId) =>
      _mutate(() => _repository.delete(expenseId));

  Future<bool> _mutate(Future<void> Function() action) async {
    if (_mutating || state.isSyncing) return false;
    _mutating = true;
    try {
      await action();
      if (!ref.mounted) return false;
      await loadFirstPage();
      return ref.mounted;
    } on AppFailure catch (failure) {
      if (ref.mounted) state = state.copyWith(message: failure.message);
      return false;
    } finally {
      _mutating = false;
    }
  }

  Future<void> syncFromGmail() async {
    if (state.isSyncing || _mutating) {
      return;
    }
    state = state.copyWith(isSyncing: true, clearMessage: true);
    try {
      final service = ref.read(expenseSyncServiceProvider);
      final createdIds = await service.syncFromGmail(
        isActive: () => ref.mounted,
      );
      if (!ref.mounted) return;
      await loadFirstPage();
      if (!ref.mounted) return;
      state = state.copyWith(
        isSyncing: false,
        message: createdIds.isEmpty
            ? 'No se encontraron gastos nuevos.'
            : 'Se sincronizaron ${createdIds.length} gastos.',
      );
    } on AppFailure catch (failure) {
      if (!ref.mounted) return;
      state = state.copyWith(isSyncing: false, message: failure.message);
    } on Exception {
      if (!ref.mounted) return;
      state = state.copyWith(
        isSyncing: false,
        message: 'No se pudo sincronizar con Gmail.',
      );
    }
  }
}
