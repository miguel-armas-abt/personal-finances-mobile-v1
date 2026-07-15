import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';
import 'package:personal_finances_mobile_v1/app/dependencies.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/repository/auth_repository.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/presentation/controllers/auth_state.dart';

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

class AuthController extends Notifier<AuthState> {
  int _generation = 0;

  AuthRepository get _repository => ref.read(authRepositoryProvider);

  @override
  AuthState build() {
    unawaited(
      Future<void>.microtask(() async {
        if (ref.mounted && _generation == 0) await restoreSession();
      }),
    );
    return const AuthState.checking();
  }

  Future<void> restoreSession() async {
    final generation = ++_generation;
    state = const AuthState.checking();
    try {
      final session = await _repository.restoreSession();
      if (!ref.mounted || generation != _generation) return;
      state = session == null
          ? const AuthState.unauthenticated()
          : AuthState.authenticated(session);
    } on AppFailure catch (failure) {
      if (ref.mounted && generation == _generation) {
        state = AuthState.unauthenticated(message: failure.message);
      }
    }
  }

  Future<void> signInWithGoogle() async {
    if (state.isSubmitting) {
      return;
    }
    final generation = ++_generation;
    state = state.copyWith(isSubmitting: true, clearMessage: true);
    try {
      final session = await _repository.signInWithGoogle();
      if (ref.mounted && generation == _generation) {
        state = AuthState.authenticated(session);
      }
    } on AppFailure catch (failure) {
      if (ref.mounted && generation == _generation) {
        state = AuthState.unauthenticated(message: failure.message);
      }
    }
  }

  Future<void> signOut() async {
    _generation++;
    final logout = _repository.signOut();
    state = const AuthState.checking();
    try {
      await logout;
      if (ref.mounted) state = const AuthState.unauthenticated();
    } on AppFailure catch (failure) {
      if (ref.mounted) {
        state = AuthState.unauthenticated(message: failure.message);
      }
    }
  }
}
