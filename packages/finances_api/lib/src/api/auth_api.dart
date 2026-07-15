//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

// ignore: unused_import
import 'dart:convert';
import 'package:finances_api/src/deserialize.dart';
import 'package:dio/dio.dart';

import 'package:finances_api/src/model/access_token_response_dto.dart';
import 'package:finances_api/src/model/error_dto.dart';
import 'package:finances_api/src/model/refresh_token_request_dto.dart';
import 'package:finances_api/src/model/sign_in_request_dto.dart';

class AuthApi {
  final Dio _dio;

  const AuthApi(this._dio);

  /// Refrescar sesion
  /// La operacion rota el refresh token y genera una nueva sesion de la aplicacion.
  ///
  /// Parameters:
  /// * [callerName]
  /// * [traceParent]
  /// * [refreshTokenRequestDto]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [AccessTokenResponseDto] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<AccessTokenResponseDto>> refreshToken({
    required String callerName,
    required String traceParent,
    required RefreshTokenRequestDto refreshTokenRequestDto,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/auth/refresh';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
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
      _bodyData = jsonEncode(refreshTokenRequestDto);
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

    AccessTokenResponseDto? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<AccessTokenResponseDto, AccessTokenResponseDto>(
              rawData,
              'AccessTokenResponseDto',
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

    return Response<AccessTokenResponseDto>(
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

  /// Iniciar sesion con Google
  /// La operacion autentica un usuario con Google y genera una sesion de la aplicacion.
  ///
  /// Parameters:
  /// * [callerName]
  /// * [traceParent]
  /// * [signInRequestDto]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [AccessTokenResponseDto] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<AccessTokenResponseDto>> signInWithGoogle({
    required String callerName,
    required String traceParent,
    SignInRequestDto? signInRequestDto,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/auth/google/sign-in';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
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
      _bodyData = jsonEncode(signInRequestDto);
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

    AccessTokenResponseDto? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<AccessTokenResponseDto, AccessTokenResponseDto>(
              rawData,
              'AccessTokenResponseDto',
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

    return Response<AccessTokenResponseDto>(
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
