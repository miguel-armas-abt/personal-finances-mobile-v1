import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finances_mobile_v1/commons/utils/backend_date_time_format.dart';

void main() {
  test(
    'given local date time when formatted then returns utc seconds precision',
    () {
      final dateTime = DateTime(2026, 6, 30, 8, 44, 12, 999);

      final formatted = formatBackendUtcDateTime(dateTime);

      expect(
        formatted,
        matches(RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$')),
      );
      expect(formatted, isNot(contains('.')));
    },
  );
}
