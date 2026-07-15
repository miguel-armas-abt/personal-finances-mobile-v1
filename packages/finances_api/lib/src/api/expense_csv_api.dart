//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

// ignore: unused_import
import 'dart:convert';
import 'package:finances_api/src/deserialize.dart';
import 'package:dio/dio.dart';

import 'dart:typed_data';
import 'package:finances_api/src/model/error_dto.dart';

class ExpenseCSVApi {
  final Dio _dio;

  const ExpenseCSVApi(this._dio);

  /// Exportar gastos a CSV
  /// Esta operación exporta los gastos del usuario en formato CSV aplicando filtros opcionales.
  ///
  /// Parameters:
  /// * [authorization]
  /// * [callerName]
  /// * [traceParent]
  /// * [recipient]
  /// * [category] - Categoría del gasto.
  /// * [currency] - Moneda del gasto.
  /// * [from]
  /// * [to]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Uint8List] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Uint8List>> exportCsv({
    required String authorization,
    required String callerName,
    required String traceParent,
    String? recipient,
    String? category,
    String? currency,
    String? from,
    String? to,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/expenses/csv/export';
    final _options = Options(
      method: r'GET',
      responseType: ResponseType.bytes,
      headers: <String, dynamic>{
        r'Authorization': authorization,
        r'caller-name': callerName,
        r'trace-parent': traceParent,
        ...?headers,
      },
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (recipient != null) r'recipient': recipient,
      if (category != null) r'category': category,
      if (currency != null) r'currency': currency,
      if (from != null) r'from': from,
      if (to != null) r'to': to,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Uint8List? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null ? null : rawData as Uint8List;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Uint8List>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }
}
