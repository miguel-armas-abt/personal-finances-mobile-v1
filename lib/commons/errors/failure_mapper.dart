import 'package:dio/dio.dart';
import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';

AppFailure mapDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.cancel:
      return const CancelledFailure();
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const NetworkFailure('El servicio tardó demasiado en responder.');
    case DioExceptionType.connectionError:
    case DioExceptionType.badCertificate:
      return const NetworkFailure('No se pudo conectar con el servicio.');
    default:
      break;
  }
  if (error.error is FormatException ||
      error.error is TypeError ||
      (error.type == DioExceptionType.unknown && error.response != null)) {
    return const DecodingFailure();
  }
  final status = error.response?.statusCode;
  final data = error.response?.data;
  final code = data is Map ? data['code'] : null;
  final origin = data is Map ? data['origin'] : null;
  return switch (status) {
    400 || 422 => ValidationFailure(
      'Revisa los datos ingresados.',
      status: status,
      code: code?.toString(),
    ),
    401 => const UnauthorizedFailure(),
    404 => const NotFoundFailure(),
    403 => RemoteFailure(
      'No tienes permiso para realizar esta operación.',
      status,
      code,
      origin,
    ),
    409 => RemoteFailure(
      'Los datos cambiaron. Actualiza e intenta otra vez.',
      status,
      code,
      origin,
    ),
    429 => RemoteFailure(
      'Demasiadas solicitudes. Intenta más tarde.',
      status,
      code,
      origin,
    ),
    null => const NetworkFailure('No se pudo conectar con el servicio.'),
    _ => RemoteFailure(
      'No se pudo completar la operación.',
      status,
      code,
      origin,
    ),
  };
}
