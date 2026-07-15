import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';
import 'package:personal_finances_mobile_v1/app/dependencies.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/model/expense_category.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/repository/category_repository.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';

final categoriesControllerProvider =
    AsyncNotifierProvider.autoDispose<
      CategoriesController,
      ExpenseCategorySettings
    >(CategoriesController.new);

class CategoriesController extends AsyncNotifier<ExpenseCategorySettings> {
  CategoryRepository get _repository => ref.read(categoryRepositoryProvider);

  @override
  Future<ExpenseCategorySettings> build() {
    return _repository.findAll();
  }

  Future<void> save(ExpenseCategorySettings settings) async {
    await _repository.save(settings);
    if (!ref.mounted) return;
    state = AsyncData(settings);
    try {
      final refreshed = await _repository.findAll();
      if (ref.mounted) state = AsyncData(refreshed);
    } on AppFailure {
      // The save already succeeded. Keep the saved values if refresh fails.
    }
  }

  Future<int> assignExisting({
    required DateTime from,
    required bool overwriteExistingCategories,
  }) async {
    try {
      final updated = await _repository.assignExisting(
        from: from,
        overwriteExistingCategories: overwriteExistingCategories,
      );
      if (ref.mounted) ref.invalidateSelf();
      return updated;
    } on AppFailure {
      rethrow;
    }
  }

  ExpenseCategorySettings emptySettings() {
    return const ExpenseCategorySettings(
      currency: CurrencyCode.pen,
      categories: [],
    );
  }
}
