import 'package:personal_finances_mobile_v1/personal_finances/auth/session/model/user_session.dart';

enum AuthStatus { checking, unauthenticated, authenticated }

class AuthState {
  const AuthState({
    required this.status,
    this.session,
    this.message,
    this.isSubmitting = false,
  });

  const AuthState.checking() : this(status: AuthStatus.checking);

  const AuthState.unauthenticated({String? message})
    : this(status: AuthStatus.unauthenticated, message: message);

  const AuthState.authenticated(UserSession session)
    : this(status: AuthStatus.authenticated, session: session);

  final AuthStatus status;
  final UserSession? session;
  final String? message;
  final bool isSubmitting;

  AuthState copyWith({
    AuthStatus? status,
    UserSession? session,
    String? message,
    bool? isSubmitting,
    bool clearMessage = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      session: session ?? this.session,
      message: clearMessage ? null : message ?? this.message,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
