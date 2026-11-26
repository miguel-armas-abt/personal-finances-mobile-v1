import 'package:dio/dio.dart';
import 'package:personal_finances_mobile_v1/commons/config/rest_log_config.dart';
import 'package:personal_finances_mobile_v1/commons/logging/app_logger.dart';
import 'package:personal_finances_mobile_v1/commons/config/app_config.dart';
import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';
import 'package:personal_finances_mobile_v1/commons/errors/failure_mapper.dart';
import 'package:personal_finances_mobile_v1/commons/persistence/secure_token_storage.dart';
import 'package:personal_finances_mobile_v1/commons/utils/trace_parent.dart';
import 'package:personal_finances_mobile_v1/commons/network/rest_log_interceptor.dart';

class ApiTransport {
  ApiTransport(AppConfig config, this._tokens)
    : callerName = config.callerName,
      dio = Dio(
        BaseOptions(
          baseUrl: config.apiBaseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 20),
          sendTimeout: const Duration(seconds: 20),
        ),
      ) {
    dio.interceptors.add(
      RestLogInterceptor(
        config: RestLogConfig.fromEnvironment(),
        traceHeaderName: 'trace-parent',
        write: AppLogger.rest,
      ),
    );
  }

  final String callerName;
  final Dio dio;
  final TokenStorage _tokens;

  Future<String> authorization() async {
    final token = await _tokens.readAccessToken();
    if (token == null || token.isEmpty) throw const UnauthorizedFailure();
    return 'Bearer $token';
  }

  String trace() => createTraceParent();

  Map<String, Object?> operation(String name) => {
    RestLogInterceptor.operationKey: name,
  };

  Future<T> run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (error) {
      throw mapDioException(error);
    } on FormatException {
      throw const DecodingFailure();
    }
  }
}

T requireValue<T>(T? value, String field) {
  if (value == null || (value is String && value.trim().isEmpty)) {
    throw FormatException('Missing $field');
  }
  return value;
}
