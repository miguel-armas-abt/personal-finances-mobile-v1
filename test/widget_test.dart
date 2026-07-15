import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finances_mobile_v1/app/dependencies.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/model/auth_user.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/model/user_session.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/repository/auth_repository.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/presentation/pages/login_page.dart';

void main() {
  testWidgets(
    'given unauthenticated user when app starts then login action is visible',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(_FakeAuthRepository()),
          ],
          child: const MaterialApp(home: LoginPage()),
        ),
      );
      await tester.pump();

      expect(find.text('Finanzas Personales'), findsOneWidget);
      expect(find.text('Continuar con Google'), findsOneWidget);
    },
  );
}

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<String> requestGmailAccessToken() async {
    return 'gmail-token';
  }

  @override
  Future<UserSession?> restoreSession() async {
    return null;
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<UserSession> signInWithGoogle() async {
    return const UserSession(
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
      expiresIn: 1800,
      user: AuthUser(
        id: 'user-id',
        email: 'user@example.com',
        fullName: 'User Example',
        plan: 'FREE',
        gmailConnected: true,
      ),
    );
  }
}
