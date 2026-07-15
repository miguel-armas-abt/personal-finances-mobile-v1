sealed class AppFailure {
  const AppFailure(this.message);

  final String message;
}

class NetworkFailure extends AppFailure {
  const NetworkFailure(super.message);
}

class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure([super.message = 'La sesión expiró.']);
}

class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message, {this.status, this.code});

  final int? status;
  final String? code;
}

class NotFoundFailure extends AppFailure {
  const NotFoundFailure([super.message = 'El recurso no existe.']);
}

class UnknownFailure extends AppFailure {
  const UnknownFailure([
    super.message = 'No hemos podido completar la operación.',
  ]);
}

class DecodingFailure extends AppFailure {
  const DecodingFailure([
    super.message = 'El servicio devolvió datos inválidos.',
  ]);
}

class CancelledFailure extends AppFailure {
  const CancelledFailure([super.message = 'Operación cancelada.']);
}

class RemoteFailure extends AppFailure {
  const RemoteFailure(super.message, this.status, this.code, this.origin);

  final int? status;
  final Object? code;
  final Object? origin;
}
