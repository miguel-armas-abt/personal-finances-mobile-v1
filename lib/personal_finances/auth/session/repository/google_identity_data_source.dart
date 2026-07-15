import 'package:google_sign_in/google_sign_in.dart';
import 'package:personal_finances_mobile_v1/commons/config/app_config.dart';

class GoogleIdentityDataSource {
  GoogleIdentityDataSource(this._config);

  static const gmailReadonlyScope =
      'https://www.googleapis.com/auth/gmail.readonly';

  final AppConfig _config;
  Future<void>? _initialization;

  Future<String> signInAndReadIdToken() async {
    await _initialize();
    final account = await GoogleSignIn.instance.authenticate();
    final idToken = account.authentication.idToken;
    if (idToken == null || idToken.isEmpty) {
      throw const GoogleSignInException(
        code: GoogleSignInExceptionCode.unknownError,
        description: 'Google no devolvió un idToken.',
      );
    }
    return idToken;
  }

  Future<String> requestGmailAccessToken() async {
    await _initialize();
    final account = await GoogleSignIn.instance.authenticate(
      scopeHint: const <String>[gmailReadonlyScope],
    );
    final authorization = await account.authorizationClient.authorizeScopes(
      const <String>[gmailReadonlyScope],
    );
    return authorization.accessToken;
  }

  Future<void> signOut() async {
    await _initialize();
    await GoogleSignIn.instance.signOut();
  }

  Future<void> _initialize() async {
    try {
      await (_initialization ??= GoogleSignIn.instance.initialize(
        clientId: _config.googleClientId,
        serverClientId: _config.googleWebClientId,
      ));
    } on GoogleSignInException {
      _initialization = null;
      rethrow;
    }
  }
}
