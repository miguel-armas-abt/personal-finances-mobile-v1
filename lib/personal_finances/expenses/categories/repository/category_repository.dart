import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/model/expense_category.dart';

abstract interface class CategoryRepository {
  Future<ExpenseCategorySettings> findAll();

  Future<void> save(ExpenseCategorySettings settings);

  Future<int> assignExisting({
    required DateTime from,
    required bool overwriteExistingCategories,
  });
}
