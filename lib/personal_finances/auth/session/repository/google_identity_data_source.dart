import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:personal_finances_mobile_v1/commons/config/app_config.dart';

class GoogleIdentityDataSource {
  GoogleIdentityDataSource(this._config);

  static const gmailReadonlyScope =
      'https://www.googleapis.com/auth/gmail.readonly';

  final AppConfig _config;
  Future<void>? _initialization;
  Future<GoogleSignInAccount?>? _lightweightRestore;
  GoogleSignInAccount? _account;
  StreamSubscription<GoogleSignInAuthenticationEvent>? _authEvents;

  Future<String> signInAndReadIdToken() async {
    await _initialize();
    final account = await GoogleSignIn.instance.authenticate();
    _account = account;
    final idToken = account.authentication.idToken;
    if (idToken == null || idToken.isEmpty) {
      throw const GoogleSignInException(
        code: GoogleSignInExceptionCode.unknownError,
        description: 'Google no devolvió un idToken.',
      );
    }
    return idToken;
  }

  Future<String?> requestGmailAccessTokenIfAuthorized() async {
    await _initialize();
    var account = _account;
    if (account == null) {
      try {
        account = await (_lightweightRestore ??= _restoreLightweightAccount());
        _account = account;
      } on GoogleSignInException {
        _lightweightRestore = null;
        return null;
      }
    }
    if (account == null) return null;
    final authorization = await account.authorizationClient
        .authorizationForScopes(const <String>[gmailReadonlyScope]);
    return authorization?.accessToken;
  }

  Future<GoogleSignInAccount?> _restoreLightweightAccount() async {
    final restoration = GoogleSignIn.instance
        .attemptLightweightAuthentication();
    if (restoration == null) return null;
    return restoration;
  }

  Future<String> requestGmailAccessToken() async {
    await _initialize();
    final account = await GoogleSignIn.instance.authenticate(
      scopeHint: const <String>[gmailReadonlyScope],
    );
    _account = account;
    final authorization = await account.authorizationClient.authorizeScopes(
      const <String>[gmailReadonlyScope],
    );
    return authorization.accessToken;
  }

  Future<void> signOut() async {
    await _initialize();
    await GoogleSignIn.instance.signOut();
    _account = null;
    _lightweightRestore = null;
  }

  Future<void> _initialize() async {
    try {
      await (_initialization ??= GoogleSignIn.instance.initialize(
        clientId: _config.googleClientId,
        serverClientId: _config.googleWebClientId,
      ));
      _authEvents ??= GoogleSignIn.instance.authenticationEvents.listen((
        event,
      ) {
        switch (event) {
          case GoogleSignInAuthenticationEventSignIn(:final user):
            _account = user;
          case GoogleSignInAuthenticationEventSignOut():
            _account = null;
        }
      });
    } on GoogleSignInException {
      _initialization = null;
      rethrow;
    }
  }
}
