import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/service/expense_sync_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finances_mobile_v1/commons/config/app_config.dart';
import 'package:personal_finances_mobile_v1/commons/persistence/secure_token_storage.dart';
import 'package:personal_finances_mobile_v1/commons/network/api_client.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/repository/auth_repository.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/repository/auth_repository_impl.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/repository/google_identity_data_source.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/repository/expense_repository.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/repository/expense_repository_impl.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/repository/category_repository.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/repository/category_repository_impl.dart';

final _transportProvider = Provider<ApiTransport>((ref) {
  final transport = ApiTransport(
    ref.watch(appConfigProvider),
    ref.watch(tokenStorageProvider),
  );
  ref.onDispose(() => transport.dio.close(force: true));
  return transport;
});

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.watch(_transportProvider),
    GoogleIdentityDataSource(ref.watch(appConfigProvider)),
    ref.watch(tokenStorageProvider),
  ),
);

final expenseRepositoryProvider = Provider<ExpenseRepository>(
  (ref) => ExpenseRepositoryImpl(ref.watch(_transportProvider)),
);

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(ref.watch(_transportProvider)),
);

final expenseSyncServiceProvider = Provider<ExpenseSyncService>(
  (ref) => ExpenseSyncService(
    ref.watch(authRepositoryProvider),
    ref.watch(expenseRepositoryProvider),
  ),
);
