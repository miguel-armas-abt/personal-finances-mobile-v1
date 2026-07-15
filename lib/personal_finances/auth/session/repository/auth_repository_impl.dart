import 'package:finances_api/finances_api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:personal_finances_mobile_v1/commons/network/api_client.dart';
import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';
import 'package:personal_finances_mobile_v1/commons/logging/app_logger.dart';
import 'package:personal_finances_mobile_v1/commons/persistence/secure_token_storage.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/mapper/session_mapper.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/model/user_session.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/repository/auth_repository.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/repository/google_identity_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._transport, this._identity, this._tokens)
    : _api = FinancesApi(dio: _transport.dio).getAuthApi();

  final ApiTransport _transport;
  final GoogleIdentityDataSource _identity;
  final TokenStorage _tokens;
  final AuthApi _api;
  Future<UserSession?>? _restoration;
  int _generation = 0;

  @override
  Future<UserSession> signInWithGoogle() async {
    final generation = ++_generation;
    try {
      final idToken = await _identity.signInAndReadIdToken();
      return await _transport.run(() async {
        final response = await _api.signInWithGoogle(
          callerName: _transport.callerName,
          traceParent: _transport.trace(),
          extra: _transport.operation('signInWithGoogle'),
          signInRequestDto: SignInRequestDto(idToken: idToken),
        );
        return _persist(
          mapSession(requireValue(response.data, 'session')),
          generation,
        );
      });
    } on GoogleSignInException catch (error) {
      AppLogger.warning(
        'Inicio de sesión con Google: ${error.code.name}',
        name: 'auth',
      );
      if (error.code == GoogleSignInExceptionCode.clientConfigurationError) {
        throw const ValidationFailure(
          'Revisa la configuración OAuth de Google para esta compilación.',
        );
      }
      throw const ValidationFailure(
        'No se completó el inicio de sesión con Google.',
      );
    }
  }

  @override
  Future<UserSession?> restoreSession() async {
    final active = _restoration;
    if (active != null) return active;
    final refresh = _restore(_generation);
    _restoration = refresh;
    try {
      return await refresh;
    } finally {
      _restoration = null;
    }
  }

  Future<UserSession?> _restore(int generation) async {
    final token = await _tokens.readRefreshToken();
    if (token == null || token.isEmpty || generation != _generation) {
      return null;
    }
    try {
      return await _transport.run(() async {
        final response = await _api.refreshToken(
          callerName: _transport.callerName,
          traceParent: _transport.trace(),
          extra: _transport.operation('refreshToken'),
          refreshTokenRequestDto: RefreshTokenRequestDto(refreshToken: token),
        );
        return _persist(
          mapSession(requireValue(response.data, 'session')),
          generation,
        );
      });
    } on UnauthorizedFailure {
      if (generation == _generation) await _tokens.clear();
      return null;
    }
  }

  Future<UserSession> _persist(UserSession session, int generation) async {
    if (generation != _generation) throw const CancelledFailure();
    await _tokens.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );
    if (generation != _generation) throw const CancelledFailure();
    return session;
  }

  @override
  Future<void> signOut() async {
    _generation++;
    await _tokens.clear();
    try {
      await _identity.signOut();
    } on GoogleSignInException {
      throw const ValidationFailure(
        'La sesi\u00f3n local se cerr\u00f3. Google no complet\u00f3 el cierre.',
      );
    }
  }

  @override
  Future<String> requestGmailAccessToken() async {
    try {
      return await _identity.requestGmailAccessToken();
    } on GoogleSignInException {
      throw const ValidationFailure(
        'No se pudo autorizar la sincronización con Gmail.',
      );
    }
  }
}
