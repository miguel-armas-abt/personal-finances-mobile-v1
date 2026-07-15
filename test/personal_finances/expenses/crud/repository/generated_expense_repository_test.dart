import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finances_mobile_v1/commons/config/app_config.dart';
import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';
import 'package:personal_finances_mobile_v1/commons/network/api_client.dart';
import 'package:personal_finances_mobile_v1/commons/persistence/secure_token_storage.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_search_criteria.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/repository/expense_repository_impl.dart';

void main() {
  late ApiTransport transport;
  late ExpenseRepositoryImpl repository;
  late _Adapter adapter;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({'access_token': 'test-token'});
    transport = ApiTransport(
      const AppConfig(
        apiBaseUrl: 'https://example.invalid/poc/personal-finances/v1',
        callerName: 'mobile-test',
        googleClientId: null,
        googleWebClientId: null,
      ),
      TokenStorage(const FlutterSecureStorage()),
    );
    adapter = _Adapter();
    transport.dio.httpClientAdapter = adapter;
    repository = ExpenseRepositoryImpl(transport);
  });

  tearDown(() => transport.dio.close());

  test(
    'given a search when sent then the generated client follows the contract',
    () async {
      adapter.body =
          '{"expenses":[{"id":"one","date":{"utc":"2026-06-30T13:44:00Z"},"currency":{"code":"PEN"},"amount":"0.29","detail":{"source":"TEST"}}],"nextCursor":"opaque+cursor"}';
      final result = await repository.search(
        criteria: ExpenseSearchCriteria(
          from: DateTime.utc(2026, 6, 30, 13, 44),
        ),
        encodedCursor: 'previous+cursor',
      );

      expect(adapter.request.uri.path, '/poc/personal-finances/v1/expenses');
      expect(
        adapter.request.uri.queryParameters['from'],
        '2026-06-30T13:44:00Z',
      );
      expect(
        adapter.request.uri.queryParameters['encodedCursor'],
        'previous+cursor',
      );
      expect(adapter.request.headers['Authorization'], 'Bearer test-token');
      expect(adapter.request.headers['caller-name'], 'mobile-test');
      expect(adapter.request.headers['trace-parent'], isA<String>());
      expect(result.expenses.single.money.amount, 29);
      expect(result.nextCursor, 'opaque+cursor');
    },
  );

  test(
    'given missing expense fields when decoded then the repository fails',
    () async {
      adapter.body = '{"expenses":[{"id":"one"}]}';
      await expectLater(
        repository.search(criteria: const ExpenseSearchCriteria()),
        throwsA(isA<DecodingFailure>()),
      );
    },
  );

  test(
    'given a no-content sync when decoded then it returns an empty result',
    () async {
      adapter.status = 204;
      expect(await repository.sync('test-gmail-token'), isEmpty);
      expect(adapter.request.headers['gmail-access-token'], 'test-gmail-token');
    },
  );
}

class _Adapter implements HttpClientAdapter {
  late RequestOptions request;
  int status = 200;
  String body = '';

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    request = options;
    return ResponseBody.fromString(
      body,
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
