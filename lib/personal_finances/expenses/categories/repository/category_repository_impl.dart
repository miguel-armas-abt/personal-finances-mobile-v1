import 'package:finances_api/finances_api.dart';
import 'package:personal_finances_mobile_v1/commons/network/api_client.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/mapper/category_request_mapper.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/model/expense_category.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._transport)
    : _api = FinancesApi(dio: _transport.dio).getExpenseCategoryApi();

  final ApiTransport _transport;
  final ExpenseCategoryApi _api;

  @override
  Future<ExpenseCategorySettings> findAll() => _transport.run(() async {
    final response = await _api.findAllCategories(
      authorization: await _transport.authorization(),
      callerName: _transport.callerName,
      traceParent: _transport.trace(),
      extra: _transport.operation('findAllCategories'),
    );
    return mapCategorySettings(
      requireValue(response.data, 'category settings'),
    );
  });

  @override
  Future<void> save(ExpenseCategorySettings settings) =>
      _transport.run(() async {
        await _api.updateExpenseCategories(
          authorization: await _transport.authorization(),
          callerName: _transport.callerName,
          traceParent: _transport.trace(),
          extra: _transport.operation('updateExpenseCategories'),
          expenseCategoryRequestDto: toCategorySettingsDto(settings),
        );
      });

  @override
  Future<int> assignExisting({
    required DateTime from,
    required bool overwriteExistingCategories,
  }) => _transport.run(() async {
    final response = await _api.assignCategories(
      authorization: await _transport.authorization(),
      callerName: _transport.callerName,
      traceParent: _transport.trace(),
      extra: _transport.operation('assignCategories'),
      expenseCategoryAssignmentRequestDto: ExpenseCategoryAssignmentRequestDto(
        from: from.toUtc(),
        overwriteExistingCategories: overwriteExistingCategories,
      ),
    );
    if (response.statusCode == 204) return 0;
    return requireValue(response.data?.ids, 'updated IDs').length;
  });
}
