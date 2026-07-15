import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';

final tokenStorageProvider = Provider<TokenStorage>(
  (ref) => TokenStorage(const FlutterSecureStorage()),
);

class TokenStorage {
  TokenStorage(this._storage);

  static const _sessionKey = 'auth_session';
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage _storage;
  Future<void> _pendingWrite = Future.value();

  Future<String?> readAccessToken() => _read(_accessTokenKey);
  Future<String?> readRefreshToken() => _read(_refreshTokenKey);

  Future<String?> _read(String key) async {
    await _pendingWrite;
    try {
      final session = await _storage.read(key: _sessionKey);
      if (session == null) return await _storage.read(key: key);
      final fields = jsonDecode(session);
      if (fields is! Map<String, dynamic> || fields[key] is! String) {
        throw const DecodingFailure();
      }
      return fields[key] as String;
    } on FormatException {
      throw const DecodingFailure();
    } on PlatformException {
      throw const UnknownFailure('No se pudo leer la sesi\u00f3n guardada.');
    }
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) => _write(
    () => _storage.write(
      key: _sessionKey,
      value: jsonEncode({
        _accessTokenKey: accessToken,
        _refreshTokenKey: refreshToken,
      }),
    ),
  );

  Future<void> clear() => _write(() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _sessionKey);
  });

  Future<void> _write(Future<void> Function() action) {
    final write = _pendingWrite.then((_) async {
      try {
        await action();
      } on PlatformException {
        throw const UnknownFailure(
          'No se pudo actualizar la sesi\u00f3n guardada.',
        );
      }
    });
    _pendingWrite = write.then<void>((_) {}, onError: (Object _) {});
    return write;
  }
}
