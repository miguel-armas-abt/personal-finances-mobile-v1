import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

abstract final class AppLogger {
  static const _enabled = bool.fromEnvironment(
    'APP_LOGS_ENABLED',
    defaultValue: !kReleaseMode,
  );

  static void info(String message, {String name = 'app'}) {
    _write(message, name: name, level: 800);
  }

  static void rest(String message) {
    if (kReleaseMode) {
      debugPrint('[rest] $message');
      return;
    }
    _write(message, name: 'rest', level: 800, enabled: true);
  }

  static void warning(
    String message, {
    String name = 'app',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _write(
      message,
      name: name,
      level: 900,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void error(
    String message, {
    String name = 'app',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _write(
      message,
      name: name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void _write(
    String message, {
    required String name,
    required int level,
    bool enabled = _enabled,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!enabled) {
      return;
    }

    developer.log(
      message,
      name: name,
      level: level,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
