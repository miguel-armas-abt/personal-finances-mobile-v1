//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

// ignore: unused_import
import 'dart:convert';
import 'package:finances_api/src/deserialize.dart';
import 'package:dio/dio.dart';

import 'package:finances_api/src/model/error_dto.dart';
import 'package:finances_api/src/model/expense_refresh_response_dto.dart';
import 'package:finances_api/src/model/expense_save_request_dto.dart';
import 'package:finances_api/src/model/expense_save_response_dto.dart';
import 'package:finances_api/src/model/expense_search_response_dto.dart';
import 'package:finances_api/src/model/expense_update_request_dto.dart';

class ExpenseApi {
  final Dio _dio;

  const ExpenseApi(this._dio);

  /// Eliminar un gasto del usuario.
  /// La operación elimina mediante ID un gasto existente del usuario.
  ///
  /// Parameters:
  /// * [authorization]
  /// * [callerName]
  /// * [traceParent]
  /// * [expenseId] - Identificador único del gasto.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> deleteExpense({
    required String authorization,
    required String callerName,
    required String traceParent,
    required String expenseId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/expenses/{expenseId}'.replaceAll(
      '{'
      r'expenseId'
      '}',
      expenseId.toString(),
    );
    final _options = Options(
      method: r'DELETE',
      headers: <String, dynamic>{
        r'Authorization': authorization,
        r'caller-name': callerName,
        r'trace-parent': traceParent,
        ...?headers,
      },
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _response;
  }

  /// Registrar un gasto del usuario.
  /// La operación registra un nuevo gasto del usuario.
  ///
  /// Parameters:
  /// * [authorization]
  /// * [callerName]
  /// * [traceParent]
  /// * [expenseSaveRequestDto]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ExpenseSaveResponseDto] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ExpenseSaveResponseDto>> saveExpense({
    required String authorization,
    required String callerName,
    required String traceParent,
    required ExpenseSaveRequestDto expenseSaveRequestDto,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/expenses';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Authorization': authorization,
        r'caller-name': callerName,
        r'trace-parent': traceParent,
        ...?headers,
      },
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      _bodyData = jsonEncode(expenseSaveRequestDto);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _options.compose(_dio.options, _path),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ExpenseSaveResponseDto? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ExpenseSaveResponseDto, ExpenseSaveResponseDto>(
              rawData,
              'ExpenseSaveResponseDto',
              growable: true,
            );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ExpenseSaveResponseDto>(
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

  /// Buscar gastos de un usuario.
  /// La operación busca los gastos de un usuario aplicando filtros opcionales y paginación basada en cursor.
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
  /// * [encodedCursor] - Cursor codificado para obtener la siguiente página de resultados.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ExpenseSearchResponseDto] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ExpenseSearchResponseDto>> searchExpenses({
    required String authorization,
    required String callerName,
    required String traceParent,
    String? recipient,
    String? category,
    String? currency,
    String? from,
    String? to,
    String? encodedCursor,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/expenses';
    final _options = Options(
      method: r'GET',
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
      if (encodedCursor != null) r'encodedCursor': encodedCursor,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ExpenseSearchResponseDto? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ExpenseSearchResponseDto, ExpenseSearchResponseDto>(
              rawData,
              'ExpenseSearchResponseDto',
              growable: true,
            );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ExpenseSearchResponseDto>(
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

  /// Sincronizar nuevos gastos desde la bandeja de correo electrónico del usuario.
  /// La operación busca nuevos mensajes de Gmail a partir del último checkpoint registrado, extrae los gastos encontrados y los guarda en base de datos.  Si se guardaron nuevos gastos, devuelve una lista con sus &#x60;gmailMessageId&#x60;.  Si no se guardó ningún gasto, responde sin contenido.
  ///
  /// Parameters:
  /// * [authorization]
  /// * [gmailAccessToken]
  /// * [callerName]
  /// * [traceParent]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ExpenseRefreshResponseDto] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ExpenseRefreshResponseDto>> syncExpenses({
    required String authorization,
    required String gmailAccessToken,
    required String callerName,
    required String traceParent,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/expenses/sync';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Authorization': authorization,
        r'gmail-access-token': gmailAccessToken,
        r'caller-name': callerName,
        r'trace-parent': traceParent,
        ...?headers,
      },
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ExpenseRefreshResponseDto? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ExpenseRefreshResponseDto, ExpenseRefreshResponseDto>(
              rawData,
              'ExpenseRefreshResponseDto',
              growable: true,
            );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ExpenseRefreshResponseDto>(
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

  /// Actualizar un gasto del usuario.
  /// La operación actualiza mediante ID un gasto existente del usuario.
  ///
  /// Parameters:
  /// * [authorization]
  /// * [callerName]
  /// * [traceParent]
  /// * [expenseId] - Identificador único del gasto.
  /// * [expenseUpdateRequestDto]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> updateExpense({
    required String authorization,
    required String callerName,
    required String traceParent,
    required String expenseId,
    required ExpenseUpdateRequestDto expenseUpdateRequestDto,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/expenses/{expenseId}'.replaceAll(
      '{'
      r'expenseId'
      '}',
      expenseId.toString(),
    );
    final _options = Options(
      method: r'PUT',
      headers: <String, dynamic>{
        r'Authorization': authorization,
        r'caller-name': callerName,
        r'trace-parent': traceParent,
        ...?headers,
      },
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      _bodyData = jsonEncode(expenseUpdateRequestDto);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _options.compose(_dio.options, _path),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _response;
  }
}
