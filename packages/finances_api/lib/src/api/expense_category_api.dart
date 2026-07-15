//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

// ignore: unused_import
import 'dart:convert';
import 'package:finances_api/src/deserialize.dart';
import 'package:dio/dio.dart';

import 'package:finances_api/src/model/error_dto.dart';
import 'package:finances_api/src/model/expense_category_assignment_request_dto.dart';
import 'package:finances_api/src/model/expense_category_request_dto.dart';
import 'package:finances_api/src/model/expense_category_response_dto.dart';
import 'package:finances_api/src/model/expense_updated_response_dto.dart';

class ExpenseCategoryApi {
  final Dio _dio;

  const ExpenseCategoryApi(this._dio);

  /// Aplicar categorías a los gastos existentes de un usuario.
  /// La operación asigna la categoría de los gastos existentes en base de datos para un usuario.
  ///
  /// Parameters:
  /// * [authorization]
  /// * [callerName]
  /// * [traceParent]
  /// * [expenseCategoryAssignmentRequestDto]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ExpenseUpdatedResponseDto] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ExpenseUpdatedResponseDto>> assignCategories({
    required String authorization,
    required String callerName,
    required String traceParent,
    ExpenseCategoryAssignmentRequestDto? expenseCategoryAssignmentRequestDto,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/expenses/categories/assignment';
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
      _bodyData = jsonEncode(expenseCategoryAssignmentRequestDto);
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

    ExpenseUpdatedResponseDto? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ExpenseUpdatedResponseDto, ExpenseUpdatedResponseDto>(
              rawData,
              'ExpenseUpdatedResponseDto',
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

    return Response<ExpenseUpdatedResponseDto>(
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

  /// Buscar las categorías de gastos configuradas por el usuario.
  /// Esta operación busca las categorías de gastos configuradas por el usuario.
  ///
  /// Parameters:
  /// * [authorization]
  /// * [callerName]
  /// * [traceParent]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ExpenseCategoryResponseDto] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ExpenseCategoryResponseDto>> findAllCategories({
    required String authorization,
    required String callerName,
    required String traceParent,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/expenses/categories';
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

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ExpenseCategoryResponseDto? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ExpenseCategoryResponseDto, ExpenseCategoryResponseDto>(
              rawData,
              'ExpenseCategoryResponseDto',
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

    return Response<ExpenseCategoryResponseDto>(
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

  /// Registrar o actualizar las categorías de gastos del usuario.
  /// Esta operación registra o actualiza las categorías de gastos del usuario.
  ///
  /// Parameters:
  /// * [authorization]
  /// * [callerName]
  /// * [traceParent]
  /// * [expenseCategoryRequestDto]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> updateExpenseCategories({
    required String authorization,
    required String callerName,
    required String traceParent,
    required ExpenseCategoryRequestDto expenseCategoryRequestDto,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/expenses/categories';
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
      _bodyData = jsonEncode(expenseCategoryRequestDto);
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
