import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_search_criteria.dart';

class ExpensesState {
  const ExpensesState({
    required this.expenses,
    required this.criteria,
    this.nextCursor,
    this.omittedCount = 0,
    this.message,
    this.loadError,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isSyncing = false,
  });

  const ExpensesState.initial()
    : this(
        expenses: const [],
        criteria: const ExpenseSearchCriteria(),
        isLoading: true,
      );

  final List<Expense> expenses;
  final ExpenseSearchCriteria criteria;
  final String? nextCursor;
  final int omittedCount;
  final String? message;
  final String? loadError;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isSyncing;

  bool get hasMore => nextCursor != null && nextCursor!.isNotEmpty;

  ExpensesState copyWith({
    List<Expense>? expenses,
    ExpenseSearchCriteria? criteria,
    String? nextCursor,
    int? omittedCount,
    String? message,
    String? loadError,
    bool clearLoadError = false,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isSyncing,
    bool clearMessage = false,
    bool clearCursor = false,
  }) {
    return ExpensesState(
      expenses: expenses ?? this.expenses,
      criteria: criteria ?? this.criteria,
      omittedCount: omittedCount ?? this.omittedCount,
      nextCursor: clearCursor ? null : nextCursor ?? this.nextCursor,
      message: clearMessage ? null : message ?? this.message,
      loadError: clearLoadError ? null : loadError ?? this.loadError,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSyncing: isSyncing ?? this.isSyncing,
    );
  }
}
