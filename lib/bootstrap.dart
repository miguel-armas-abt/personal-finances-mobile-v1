import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:personal_finances_mobile_v1/app/app.dart';
import 'package:personal_finances_mobile_v1/commons/logging/app_logger.dart';

Future<void> bootstrap() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (details) {
        AppLogger.error(
          'Flutter error: ${details.exception.runtimeType}',
          name: 'app.error',
          stackTrace: details.stack,
        );
      };

      PlatformDispatcher.instance.onError = (error, stackTrace) {
        AppLogger.error(
          'Uncaught platform error: ${error.runtimeType}',
          name: 'app.error',
          stackTrace: stackTrace,
        );
        return true;
      };

      await initializeDateFormatting('es_PE');

      runApp(const ProviderScope(child: PersonalFinancesApp()));
    },
    (error, stackTrace) {
      AppLogger.error(
        'Uncaught zone error: ${error.runtimeType}',
        name: 'app.error',
        stackTrace: stackTrace,
      );
    },
  );
}
