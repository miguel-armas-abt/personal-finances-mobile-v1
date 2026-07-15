import 'package:finances_api/finances_api.dart';
import 'package:personal_finances_mobile_v1/commons/network/api_client.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/model/auth_user.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/model/user_session.dart';

UserSession mapSession(AccessTokenResponseDto dto) {
  final user = requireValue(dto.user, 'session user');
  final expiresIn = requireValue(dto.expiresIn, 'session lifetime');
  if (expiresIn <= 0 || expiresIn != expiresIn.truncate()) {
    throw const FormatException('Invalid session lifetime');
  }
  return UserSession(
    accessToken: requireValue(dto.accessToken, 'access token'),
    refreshToken: requireValue(dto.refreshToken, 'refresh token'),
    expiresIn: expiresIn.toInt(),
    user: AuthUser(
      id: requireValue(user.id, 'user ID'),
      email: requireValue(user.email, 'user email'),
      fullName: requireValue(user.fullName, 'user name'),
      pictureUrl: user.pictureUrl,
      plan: requireValue(user.plan, 'user plan'),
      gmailConnected: user.gmailConnected ?? false,
    ),
  );
}
