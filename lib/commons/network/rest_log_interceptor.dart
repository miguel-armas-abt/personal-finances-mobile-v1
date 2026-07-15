import 'dart:convert';

import 'package:dio/dio.dart';

final class RestLogInterceptor extends Interceptor {
  RestLogInterceptor({
    required this.enabled,
    required this.write,
    this.traceHeaderName = 'traceparent',
  });

  static const operationKey = 'rest.operation';
  static const _timerKey = 'commons.restLog.stopwatch';
  static final _labelPattern = RegExp(r'^[a-zA-Z0-9_.-]{1,80}$');
  static final _tracePattern = RegExp(
    r'^00-([0-9a-f]{32})-([0-9a-f]{16})-([0-9a-f]{2})$',
  );

  final bool enabled;
  final void Function(String message) write;
  final String traceHeaderName;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (enabled) {
      options.extra[_timerKey] = Stopwatch()..start();
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _record(response.requestOptions, response.statusCode, null);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _record(err.requestOptions, err.response?.statusCode, err.type.name);
    handler.next(err);
  }

  void _record(RequestOptions options, int? status, String? errorType) {
    if (!enabled) return;

    try {
      final timer = options.extra.remove(_timerKey);
      if (timer is Stopwatch) timer.stop();

      final operation = options.extra[operationKey];
      final event = <String, Object?>{
        'event': 'rest.completed',
        'method': _labelPattern.hasMatch(options.method)
            ? options.method
            : 'unknown',
        'operation': operation is String && _labelPattern.hasMatch(operation)
            ? operation
            : 'unlabeled',
        'status': status,
        if (timer is Stopwatch) 'durationMs': timer.elapsedMilliseconds,
        'errorType': ?errorType,
      };

      for (final header in options.headers.entries) {
        if (header.key.toLowerCase() != traceHeaderName.toLowerCase()) {
          continue;
        }
        final value = header.value;
        final match = value is String ? _tracePattern.firstMatch(value) : null;
        if (match != null &&
            match[1] != '00000000000000000000000000000000' &&
            match[2] != '0000000000000000') {
          event['traceId'] = match[1];
          break;
        }
      }

      write(jsonEncode(event));
    } on Object {
      return;
    }
  }
}
