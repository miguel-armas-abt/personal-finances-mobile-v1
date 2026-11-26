final class RestLogConfig {
  const RestLogConfig({
    required this.headers,
    required this.bodyFields,
    this.maxBodyChars,
  });

  factory RestLogConfig.fromEnvironment() => RestLogConfig(
    headers: _readSet(
      const String.fromEnvironment('APP_REST_LOG_MASK_HEADERS'),
      ignoreCase: true,
    ),
    bodyFields: _readSet(
      const String.fromEnvironment('APP_REST_LOG_MASK_BODY_FIELDS'),
    ),
    maxBodyChars: _readPositiveInt(
      const String.fromEnvironment('APP_REST_LOG_MAX_BODY_CHARS'),
    ),
  );

  final Set<String> headers;
  final Set<String> bodyFields;
  final int? maxBodyChars;

  static int? _readPositiveInt(String value) {
    final parsed = int.tryParse(value.trim());
    return parsed != null && parsed > 0 ? parsed : null;
  }

  static Set<String> _readSet(String value, {bool ignoreCase = false}) =>
      Set.unmodifiable(
        value
            .split(',')
            .map((name) => name.trim())
            .where((name) => name.isNotEmpty)
            .map((name) => ignoreCase ? name.toLowerCase() : name),
      );
}
