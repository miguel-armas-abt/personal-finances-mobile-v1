import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_search_criteria.dart';

class ExpensesState {
  const ExpensesState({
    required this.expenses,
    required this.criteria,
    this.nextCursor,
    this.message,
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
  final String? message;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isSyncing;

  bool get hasMore => nextCursor != null && nextCursor!.isNotEmpty;

  ExpensesState copyWith({
    List<Expense>? expenses,
    ExpenseSearchCriteria? criteria,
    String? nextCursor,
    String? message,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isSyncing,
    bool clearMessage = false,
    bool clearCursor = false,
  }) {
    return ExpensesState(
      expenses: expenses ?? this.expenses,
      criteria: criteria ?? this.criteria,
      nextCursor: clearCursor ? null : nextCursor ?? this.nextCursor,
      message: clearMessage ? null : message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSyncing: isSyncing ?? this.isSyncing,
    );
  }
}
