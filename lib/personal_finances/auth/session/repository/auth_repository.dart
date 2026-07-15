import 'package:personal_finances_mobile_v1/personal_finances/auth/session/model/user_session.dart';

abstract interface class AuthRepository {
  Future<UserSession> signInWithGoogle();

  Future<UserSession?> restoreSession();

  Future<void> signOut();

  Future<String> requestGmailAccessToken();
}
