final _decimalPattern = RegExp(r'^(-?)(\d+)(?:\.(\d{1,2}))?$');

int parseMinorUnits(String text) {
  final match = _decimalPattern.firstMatch(text.trim());
  if (match == null) throw const FormatException('Invalid decimal amount');
  final fraction = (match[3] ?? '').padRight(2, '0');
  final magnitude = BigInt.parse('${match[2]}$fraction');
  if (magnitude > BigInt.from(9007199254740991)) {
    throw const FormatException('Amount exceeds safe integer range');
  }
  return match[1] == '-' ? -magnitude.toInt() : magnitude.toInt();
}

String formatMinorUnits(int units) {
  final magnitude = units.abs();
  final sign = units < 0 ? '-' : '';
  return '$sign${magnitude ~/ 100}.${(magnitude % 100).toString().padLeft(2, '0')}';
}

int? tryParseMinorUnits(String text) {
  try {
    return parseMinorUnits(text);
  } on FormatException {
    return null;
  }
}
