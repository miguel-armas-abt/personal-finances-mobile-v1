import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:personal_finances_mobile_v1/commons/config/rest_log_config.dart';
import 'package:personal_finances_mobile_v1/commons/network/rest_log_details.dart';

final class RestLogInterceptor extends Interceptor {
  RestLogInterceptor({
    required RestLogConfig config,
    required this.write,

    this.traceHeaderName = 'traceparent',
  }) : _details = RestLogDetails(config);

  static const operationKey = 'rest.operation';
  static const _timerKey = 'commons.restLog.stopwatch';
  static final _labelPattern = RegExp(r'^[a-zA-Z0-9_.-]{1,80}$');
  static final _tracePattern = RegExp(
    r'^00-([0-9a-f]{32})-([0-9a-f]{16})-([0-9a-f]{2})$',
  );

  final void Function(String message) write;
  final String traceHeaderName;
  final RestLogDetails _details;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_timerKey] = Stopwatch()..start();
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _record(response.requestOptions, response, null);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _record(err.requestOptions, err.response, err.type.name);
    handler.next(err);
  }

  void _record(
    RequestOptions options,
    Response<dynamic>? response,
    String? errorType,
  ) {
    try {
      final timer = options.extra.remove(_timerKey);
      if (timer is Stopwatch) timer.stop();

      final operation = options.extra[operationKey];
      final label = operation is String && _labelPattern.hasMatch(operation)
          ? operation
          : 'unlabeled';
      final event = <String, Object?>{
        'event': 'rest.completed',
        'method': _labelPattern.hasMatch(options.method)
            ? options.method
            : 'unknown',
        'operation': label,
        'status': response?.statusCode,
        if (timer is Stopwatch) 'durationMs': timer.elapsedMilliseconds,
        'errorType': ?errorType,
      };

      for (final header in options.headers.entries) {
        if (header.key.toLowerCase() != traceHeaderName.toLowerCase() ||
            _details.masksHeader(header.key)) {
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

      event.addAll(
        _details.forExchange(
          request: options,
          response: response,
          operation: label,
        ),
      );
      write(jsonEncode(event));
    } on Object {
      return;
    }
  }
}
