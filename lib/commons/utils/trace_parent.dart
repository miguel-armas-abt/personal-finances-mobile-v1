import 'dart:math';

String createTraceParent() {
  final random = Random.secure();
  final traceId = _hex(random, 16);
  final spanId = _hex(random, 8);
  return '00-$traceId-$spanId-01';
}

String _hex(Random random, int bytes) {
  final buffer = StringBuffer();
  for (var i = 0; i < bytes; i++) {
    buffer.write(random.nextInt(256).toRadixString(16).padLeft(2, '0'));
  }
  return buffer.toString();
}
