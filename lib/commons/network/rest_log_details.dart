import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:personal_finances_mobile_v1/commons/config/rest_log_config.dart';

final class RestLogDetails {
  RestLogDetails(RestLogConfig config)
    : _maskedHeaders = config.headers.map((name) => name.toLowerCase()).toSet(),
      _maskedBodyPaths = Set.of(config.bodyFields),
      _maxBodyChars = config.maxBodyChars;

  static const _mask = '*****';
  static const _maxHeaderEntries = 40;
  static const _routes = {
    'signInWithGoogle': '/auth/google/sign-in',
    'refreshToken': '/auth/refresh',
    'searchExpenses': '/expenses',
    'saveExpense': '/expenses',
    'updateExpense': '/expenses/{expenseId}',
    'deleteExpense': '/expenses/{expenseId}',
    'syncExpenses': '/expenses/sync',
    'findAllCategories': '/expenses/categories',
    'updateExpenseCategories': '/expenses/categories',
    'assignCategories': '/expenses/categories/assignment',
  };

  final Set<String> _maskedHeaders;
  final Set<String> _maskedBodyPaths;
  final int? _maxBodyChars;

  bool masksHeader(String name) => _maskedHeaders.contains(name.toLowerCase());

  Map<String, Object?> forExchange({
    required RequestOptions request,
    required Response<dynamic>? response,
    required String operation,
  }) {
    final requestBody = _body(request.data);
    final responseBody =
        response == null ||
            response.statusCode == 204 ||
            response.requestOptions.responseType == ResponseType.bytes ||
            response.requestOptions.responseType == ResponseType.stream
        ? null
        : _body(response.data);
    return {
      'uri': _safeUri(request.uri, _routes[operation]),
      if (request.queryParameters.isNotEmpty)
        'queryParameters': request.queryParameters.keys
            .take(_maxHeaderEntries)
            .toList(),
      'requestHeaders': _headers(request.headers),
      'requestBody': ?requestBody,
      if (response != null) ...{
        'responseHeaders': _headers(response.headers.map),
        'responseBody': ?responseBody,
      },
    };
  }

  static String _safeUri(Uri uri, String? route) {
    const knownPrefix = '/poc/personal-finances/v1';
    final suffix = switch (route) {
      null => null,
      '/expenses/{expenseId}' => RegExp(
        r'/expenses/[^/]+$',
      ).firstMatch(uri.path)?.group(0),
      _ => uri.path.endsWith(route) ? route : null,
    };
    final prefix = suffix == null
        ? null
        : uri.path.substring(0, uri.path.length - suffix.length);
    final path = switch (prefix) {
      null => '/$_mask',
      '' => route!,
      knownPrefix => '$knownPrefix$route',
      _ => '/$_mask$route',
    };
    return uri.hasAuthority && (uri.scheme == 'http' || uri.scheme == 'https')
        ? '${uri.origin}$path'
        : path;
  }

  Map<String, Object?> _headers(Map<String, Object?> headers) => {
    for (final entry in headers.entries.take(_maxHeaderEntries))
      entry.key.toLowerCase(): _headerValue(
        entry.value,
        masked: masksHeader(entry.key),
      ),
  };

  Object? _headerValue(Object? value, {required bool masked}) {
    if (value is List) {
      return value
          .take(_maxHeaderEntries)
          .map((item) => masked ? _obfuscate(item) : _scalar(item))
          .toList();
    }
    return masked ? _obfuscate(value) : _scalar(value);
  }

  Object? _body(Object? data) {
    if (data is String) {
      try {
        data = jsonDecode(data);
      } on FormatException {
        return _limitBody(data);
      }
    }
    if (data is Uint8List) return null;

    Object? preview(Object? value, String path) {
      if (_maskedBodyPaths.contains(path)) return _obfuscate(value);
      if (value is Map) {
        final result = <String, Object?>{};
        for (final entry in value.entries) {
          if (entry.key case final String key) {
            result[key] = preview(
              entry.value,
              path.isEmpty ? key : '$path.$key',
            );
          }
        }
        return result;
      }
      if (value is List) {
        final result = <Object?>[];
        for (final item in value) {
          result.add(preview(item, '$path[*]'));
        }
        return result;
      }
      return _scalar(value);
    }

    return _limitBody(preview(data, ''));
  }

  Object? _limitBody(Object? body) {
    final limit = _maxBodyChars;
    if (limit == null) return body;
    final encoded = jsonEncode(body);
    if (encoded.length <= limit) return body;
    final preview = String.fromCharCodes(encoded.runes.take(limit));
    return '$preview… [truncated; ${encoded.length} characters total]';
  }

  static Object? _scalar(Object? value) => switch (value) {
    String text => text,
    num number when number.isFinite => number,
    bool boolean => boolean,
    _ => null,
  };

  static String _obfuscate(Object? value) {
    if (value is! String || value.length <= 6) return _mask;
    return '${value.substring(0, 3)}$_mask${value.substring(value.length - 3)}';
  }
}
