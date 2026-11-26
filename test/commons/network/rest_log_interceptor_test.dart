import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:personal_finances_mobile_v1/commons/config/rest_log_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finances_mobile_v1/commons/network/rest_log_interceptor.dart';

const _trace = '00-efae01381efe175efd941db93484a63e-00f067aa0ba902b7-00';

void main() {
  test(
    'given no mask defines when logging then headers and fields are preserved',
    () async {
      final config = RestLogConfig.fromEnvironment();
      expect(config.headers, isEmpty);
      expect(config.bodyFields, isEmpty);

      final longValue = '${List.filled(600, 'x').join()}-fin';
      final authorization = 'Bearer $longValue';
      final messages = <String>[];
      final dio = _client(
        messages.add,
        status: 200,
        config: config,
        body: {'accessToken': longValue},
      );
      addTearDown(dio.close);
      await dio.post<Object?>(
        '/auth/google/sign-in',
        data: {'idToken': longValue},
        options: _options(
          'signInWithGoogle',
          headers: {'authorization': authorization},
        ),
      );

      final event = jsonDecode(messages.single) as Map<String, dynamic>;
      expect(
        event['requestHeaders'],
        containsPair('authorization', authorization),
      );
      expect(event['requestBody'], {'idToken': longValue});
      expect(event['responseBody'], {'accessToken': longValue});
    },
  );
  test(
    'given a Google 401 when explicit masks apply then diagnostics are recorded',
    () async {
      final messages = <String>[];
      final dio = _client(
        messages.add,
        status: 401,
        config: const RestLogConfig(
          headers: {'authorization', 'gmail-access-token', 'set-cookie'},
          bodyFields: {'idToken', 'message'},
        ),
        body: {
          'code': '3003',
          'origin': 'OWN',
          'message': 'failed for private@example.test',
          'unexpected': 'private-response',
        },
      );
      addTearDown(dio.close);

      await expectLater(
        dio.post<Object?>(
          '/auth/google/sign-in',
          data: jsonEncode({'idToken': 'secret-google-token'}),
          queryParameters: {'recipient': 'private-query'},
          options: _options(
            'signInWithGoogle',
            headers: {
              'Trace-Parent': _trace,
              'Authorization': 'Bearer secret-auth',
              'Gmail-Access-Token': 'secret-gmail',
              'X-Private': 'private-header',
            },
          ),
        ),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'status',
            401,
          ),
        ),
      );

      final event = jsonDecode(messages.single) as Map<String, dynamic>;
      expect(event['event'], 'rest.completed');
      expect(
        event['uri'],
        'https://example.test/poc/personal-finances/v1/auth/google/sign-in',
      );
      expect(event['status'], 401);
      expect(event['durationMs'], isA<int>());
      expect(event['traceId'], _trace.split('-')[1]);
      expect(event['queryParameters'], ['recipient']);
      expect(event['requestHeaders'], containsPair('trace-parent', _trace));
      expect(
        event['requestHeaders'],
        containsPair('authorization', 'Bea*****uth'),
      );
      expect(event['requestBody'], {'idToken': 'sec*****ken'});
      expect(
        event['responseHeaders'],
        containsPair('set-cookie', ['sec*****kie']),
      );
      expect(event['responseBody'], {
        'code': '3003',
        'origin': 'OWN',
        'message': 'fai*****est',
        'unexpected': 'private-response',
      });
      expect(
        event['requestHeaders'],
        containsPair('x-private', 'private-header'),
      );
      expect(
        messages.single,
        isNot(contains(RegExp(r'secret-|private-query|private@example'))),
      );
    },
  );

  test(
    'given custom masks when arrays and headers are logged then only configured paths are masked',
    () async {
      const config = RestLogConfig(
        headers: {'X-Custom', 'Trace-Parent'},
        bodyFields: {
          'detail.secret',
          'expenses[*].detail.secret',
          'expenses[*].amount',
        },
      );
      final messages = <String>[];
      final dio = _client(
        messages.add,
        status: 200,
        config: config,
        body: {
          'expenses': [
            {
              'detail': {'secret': 'xy', 'visible': 'kept'},
              'amount': 25,
            },
            {
              'detail': {'secret': 'abcdefghij'},
            },
          ],
        },
      );
      addTearDown(dio.close);

      await dio.post<Object?>(
        '/expenses',
        data: {
          'detail': {'secret': 'abcdefghijkl', 'visible': 'kept'},
          'code': 'custom',
        },
        options: _options(
          'saveExpense',
          headers: {
            'x-custom': 'tiny',
            'trace-parent': _trace,
            'authorization': 'test-fixture',
          },
        ),
      );

      final event = jsonDecode(messages.single) as Map<String, dynamic>;
      expect(event.containsKey('traceId'), isFalse);
      expect(event['requestHeaders'], containsPair('x-custom', '*****'));
      expect(
        event['requestHeaders'],
        containsPair('authorization', 'test-fixture'),
      );
      expect(event['requestBody'], {
        'detail': {'secret': 'abc*****jkl', 'visible': 'kept'},
        'code': 'custom',
      });
      expect(event['responseBody'], {
        'expenses': [
          {
            'detail': {'secret': '*****', 'visible': 'kept'},
            'amount': '*****',
          },
          {
            'detail': {'secret': 'abc*****hij'},
          },
        ],
      });
      expect(messages.single, isNot(contains(_trace)));
    },
  );
  test(
    'given a 204 when the exchange is logged then the path ID and body are omitted',
    () async {
      final messages = <String>[];
      final dio = _client(messages.add, status: 204);
      addTearDown(dio.close);
      await dio.delete<Object?>(
        '/expenses/private-id',
        options: _options('deleteExpense'),
      );
      final event = jsonDecode(messages.single) as Map<String, dynamic>;
      expect(
        event['uri'],
        'https://example.test/poc/personal-finances/v1/expenses/{expenseId}',
      );
      expect(event.containsKey('responseBody'), isFalse);
      expect(messages.single, isNot(contains('private-id')));
    },
  );

  test(
    'given a throwing log sink when Dio completes then success and errors reach the caller',
    () async {
      void throwingSink(String _) => throw StateError('sink unavailable');

      final success = _client(throwingSink, status: 204);
      final failure = _client(throwingSink, status: 401);
      addTearDown(success.close);
      addTearDown(failure.close);

      expect(
        (await success.delete<Object?>(
          '/expenses/id',
          options: _options('deleteExpense'),
        )).statusCode,
        204,
      );
      await expectLater(
        failure.post<Object?>(
          '/auth/refresh',
          options: _options('refreshToken'),
        ),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'status',
            401,
          ),
        ),
      );
    },
  );
}

Options _options(String operation, {Map<String, Object?>? headers}) => Options(
  headers: headers,
  extra: {RestLogInterceptor.operationKey: operation},
);

Dio _client(
  void Function(String) write, {
  required int status,
  Map<String, Object?>? body,
  RestLogConfig? config,
}) => Dio(BaseOptions(baseUrl: 'https://example.test/poc/personal-finances/v1'))
  ..httpClientAdapter = _Adapter(status, body)
  ..interceptors.add(
    RestLogInterceptor(
      config: config ?? RestLogConfig.fromEnvironment(),
      write: write,

      traceHeaderName: 'trace-parent',
    ),
  );

class _Adapter implements HttpClientAdapter {
  _Adapter(this.status, this.body);

  final int status;
  final Map<String, Object?>? body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    body == null ? '' : jsonEncode(body),
    status,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
      'set-cookie': ['secret-cookie'],
    },
  );

  @override
  void close({bool force = false}) {}
}
