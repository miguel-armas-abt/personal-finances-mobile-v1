import 'package:personal_finances_mobile_v1/personal_finances/auth/session/model/auth_user.dart';

class UserSession {
  const UserSession({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.user,
  });

  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final AuthUser user;
}
